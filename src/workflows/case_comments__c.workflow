<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>plain_text_update</fullName>
        <field>Comment__c</field>
        <formula>Rich_Comment__c</formula>
        <name>plain text update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>copy to plain</fullName>
        <actions>
            <name>plain_text_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>case_comments__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>timestamp</fullName>
        <active>false</active>
        <formula>ISCHANGED( Rich_Comment__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
