<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_Case_Assignment_alert_to_User</fullName>
        <ccEmails>jesse_roshan@yahoo.com</ccEmails>
        <description>Send Case Assignment alert to User</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Case_Alert</template>
    </alerts>
    <alerts>
        <fullName>priority_change_alert</fullName>
        <description>priority change alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>jrk@salesforce1.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Example_VisualForce_EmailTemplate</template>
    </alerts>
    <alerts>
        <fullName>survey_to_contacts_of_closed_case</fullName>
        <ccEmails>jesse_roshan@yahoo.com</ccEmails>
        <description>survey to contacts of closed case</description>
        <protected>false</protected>
        <recipients>
            <field>ContactEmail</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/casesurvey</template>
    </alerts>
    <rules>
        <fullName>Email message sent</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.CaseNumber</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send User Case Alert</fullName>
        <actions>
            <name>Send_Case_Assignment_alert_to_User</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>notEqual</operation>
            <value>null</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>email survey</fullName>
        <actions>
            <name>survey_to_contacts_of_closed_case</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>send notifications</fullName>
        <actions>
            <name>priority_change_alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>High</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
