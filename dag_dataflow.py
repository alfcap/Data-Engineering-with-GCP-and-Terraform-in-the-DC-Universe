from airflow import DAG
from airflow.providers.google.cloud.operators.dataflow import DataflowStartFlexTemplateOperator
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago
from airflow.utils.trigger_rule import TriggerRule
from airflow.exceptions import AirflowSkipException
from google.cloud import storage
import logging

# Configuration
GCS_BUCKET = 'list_of_villains_terraform_project_2025'
GCS_PATH = ''  # Put "" if you want to check the root
DATAFLOW_TEMPLATE_PATH = 'gs://dataflow-templates-europe-west9/latest/flex/GCS_Text_to_BigQuery_Xlang'
PROJECT_ID = 'batman-projet-438510'
REGION = 'us-central1'

default_args = {
    'owner': 'airflow',
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1
}


with DAG(
    'gcs_dataflow_just_treat_data',
    default_args=default_args,
    description='DAG checking a GCS bucket and launching a Dataflow job',
    schedule_interval='*/10 * * * *',  # every 10 minutes
    start_date=days_ago(1),
    catchup=False,
) as dag:

    # Task to launch the Dataflow job if the bucket is not empty
    dataflow_treat_data = DataflowStartFlexTemplateOperator(
        task_id='dataflow_treat_data',
        project_id=PROJECT_ID,
        location=REGION,
    body={
        'launchParameter': {
            'containerSpecGcsPath': DATAFLOW_TEMPLATE_PATH,
            'jobName': 'dataflow-job-{{ ds_nodash }}',
            'parameters': {
                'inputFilePattern': f"gs://{GCS_BUCKET}/joker",
                'JSONPath': "gs://gcs_of_batman_for_terraform_project_2025/arkham",
                'outputTable': "batman-projet-438510:Batcave.Arkham_Asylum",
                'bigQueryLoadingTemporaryDirectory': "gs://gcs_of_batman_for_terraform_project_2025/temp/",
                'pythonExternalTextTransformGcsPath': "gs://gcs_of_batman_for_terraform_project_2025/jail_villains",
                'pythonExternalTextTransformFunctionName': "transform_villain"
            },
            'environment': {
                'serviceAccountEmail': 'batman-service-account@batman-projet-438510.iam.gserviceaccount.com'
            }
        }
    }
)
    # Defining the task flow
    dataflow_treat_data   # Launch the Dataflow job and notify success
