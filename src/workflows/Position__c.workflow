<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_New_Position_Alert</fullName>
        <description>Email New Position Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>CEO</recipient>
            <type>roleSubordinates</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Recruiting_App_New_Position_Alert</template>
    </alerts>
    <alerts>
        <fullName>Send_email_to_queue_Members</fullName>
        <description>Send email to queue Members</description>
        <protected>false</protected>
        <recipients>
            <recipient>jrk@salesforce1.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Recrutign_App_New_Position_requires_Approval</template>
    </alerts>
    <alerts>
        <fullName>pay_above_than_million</fullName>
        <ccEmails>jesse_roshan@yahoo.com</ccEmails>
        <description>pay above than million</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/max_pay_issue</template>
    </alerts>
    <fieldUpdates>
        <fullName>Reassign_Postion_to_Queue</fullName>
        <description>Assign the Position to the Unclaimed Positions Queue</description>
        <field>OwnerId</field>
        <lookupValue>Unclaimed_Positions_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Reassign Postion to Queue</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Close_Date_to_Today</fullName>
        <field>Close_Date__c</field>
        <formula>TODAY()</formula>
        <name>Set Close Date to Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Status_to_Closed_Not_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Closed- Not Approved</literalValue>
        <name>Set Status to Closed Not Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Status_to_Open_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Open-Approved</literalValue>
        <name>Set Status to Open Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Status_to_Pending_Approval</fullName>
        <description>While a position is in an approval process, its status should be set to Pending Approval.</description>
        <field>Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Set Status to Pending Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Test_fro_assigning_to_queue</fullName>
        <field>Status__c</field>
        <literalValue>Open-Approved</literalValue>
        <name>Test fro assigning to queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>close_date_is_today</fullName>
        <field>Close_Date__c</field>
        <formula>TODAY()</formula>
        <name>close date is today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>hjhj</fullName>
        <field>Skills_Required__c</field>
        <name>hjhj</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>set_status_to_pending_approvals</fullName>
        <field>Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>set status to pending approvals</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>status_closed_nto_approvd</fullName>
        <field>Status__c</field>
        <literalValue>Closed- Not Approved</literalValue>
        <name>status-closed nto approvd</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>status_open_approved</fullName>
        <field>Status__c</field>
        <literalValue>Open-Approved</literalValue>
        <name>status open approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Assign Position to Recruiter</fullName>
        <actions>
            <name>Reassign_Postion_to_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notEqual</operation>
            <value>Recruiter,Recruting Manager</value>
        </criteriaItems>
        <description>Reassign position record to a recruiter if they were created by another type of employee</description>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Assign_Unclaimed_Position_Record_to_Recruiter</name>
                <type>Task</type>
            </actions>
            <timeLength>3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Email New Position Alert</fullName>
        <actions>
            <name>Email_New_Position_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Position__c.Status__c</field>
            <operation>equals</operation>
            <value>Open-Approved</value>
        </criteriaItems>
        <description>Send email to everyone whenever a position record is opened</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>update</fullName>
        <actions>
            <name>pay_above_than_million</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Position__c.Max_Pay__c</field>
            <operation>greaterThan</operation>
            <value>1000000</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <tasks>
        <fullName>Assign_Unclaimed_Position_Record_to_Recruiter</fullName>
        <assignedTo>Recruiting_Manager</assignedTo>
        <assignedToType>role</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Assign Unclaimed Position Record to Recruiter</subject>
    </tasks>
</Workflow>
