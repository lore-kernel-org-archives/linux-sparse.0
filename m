Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E184FC433ED
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Apr 2021 12:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9998E6023B
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Apr 2021 12:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhDTMop (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:44:45 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:46897 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231251AbhDTMop (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Apr 2021 08:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1618922653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UhsUkxVWy3Hp0UkfASf/6HSIms5uajrlLGxk1QDGARY=;
        b=YN55vqxAGRj174+e7SPxCEHkv8dkKo9NK//4W8faw61VOYMcQbSwviDEEosIaR2CmSsdTZ
        TLUPEgi3JE/y9XDu6gLLx+5+pQrEMaouRoZy+PvgivDdi9UFCKWKmNAqsQ7oUrM1rbzUcj
        x5BW+u5yX5JfPWy2cqKDsFQlRoEdTQI=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2058.outbound.protection.outlook.com [104.47.2.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-35-xlFhrhuJNk6q5g1zK0YAiQ-1; Tue, 20 Apr 2021 14:44:12 +0200
X-MC-Unique: xlFhrhuJNk6q5g1zK0YAiQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RseMQrMF9J354yLdaoi1XG7WcutRzo2PYOZxzh2SEqOF7K5XZxcbKn9/Hw/WNuS/d8fLNBbW6ztzEj5EZ2t6bZo83Xxa73vpJflxKDsgXI5+LdQ+Pwq+6Asa565APhQN/ipEKCX3NiDTzxKHXw15em681V1bk7dl8tm8ddNa+TKfeTKc44GI1GFxsraAU2eTXtGu6X9ZV4O0EYxOlpe1Ur6sGLxTy9CHH/R1pobrZ8qbnATZqdd5dyGVVQCl07Y/YeW6cree6wdu00lOiL1dYyRIBPp/BkTDGSrUoockkvmj+P/ht/Wn2ncIo+3dhMLgK9u/vWyYiKmjGyt/F4ldww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhsUkxVWy3Hp0UkfASf/6HSIms5uajrlLGxk1QDGARY=;
 b=SVjzT3kkPBGd2UnrVTx5Jgh9RpJrrTKYaM3+KmzoyJSBVaa/G41RI+zfIinpgQQ72v0hM1+1ArUoH6e718nUvzp7EEpSY8K3+A4GZSOG6sqUtAApj6o8QH3TRucMQK5K97kRfq/wDRumNc6kqUvaiKYiEbzpG/uCV6/WaJ7dnm+RJCGns3Y3a7vPt3kmYS44jOJz+QBNWJMHdzElKT/GrRoTeUEvHg0V3zznEEcFjq0c949YZ3qBjSbls0d+3qMigU90pZCXycH8yY5HBkckGHkbVcQ/vnGmZEWs+bD5EzXgMEnRSiOSQgeq/9v6BqHgS+rtnMe0q4OC+u0eqLoqHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR04MB4669.eurprd04.prod.outlook.com (2603:10a6:803:70::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Tue, 20 Apr
 2021 12:44:10 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 12:44:10 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: check idea: warn when mixing signedness in ?: operator (got
 bitten by this recently)
In-Reply-To: <20210420121602.GF1981@kadam>
References: <87wnsyzia4.fsf@suse.com> <20210420121602.GF1981@kadam>
Date:   Tue, 20 Apr 2021 14:44:08 +0200
Message-ID: <87k0oxyvl3.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:707:6a18:7884:7720:a088:898e]
X-ClientProxiedBy: ZRAP278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::15) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:707:6a18:7884:7720:a088:898e) by ZRAP278CA0005.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 12:44:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9277c14a-8136-4202-41bc-08d903f9fe5f
X-MS-TrafficTypeDiagnostic: VI1PR04MB4669:
X-Microsoft-Antispam-PRVS: <VI1PR04MB4669411D92B5A5FEB8285AF4A8489@VI1PR04MB4669.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: outrDAatKYMOdz4mNXiWldRVESPvvBjE3cn3bQ3p5ZTM3SEZDjdnx/YdMzUQXO9dyCK1zFsW5+5b5HJJzDSXUc8gMLWjZf1JbkOh5yb3npKKK6Yp3R7BVMmxMUMkKs2nodeuPoOmMLatXF5iuk6MxzldsUL3UtbVA2Rs+/r/N8Wn93rKgkE0wOj4KFmDf+s4a2jCSv+ONRo7Z8jG+L8OtnetkJ13FklHOg2G7jsaonuoQ1IH9/yh9CEMd/I6Hit2zKrio6KQIrSDQ/LQMMv6YbjxpPr2zE4ISOFmE1TE2fxcMySPDpZzdqyBPOrWZ0EYVp/BhB4diyRlEGWz8o2spLhj02mz6zbRPVlXY0YN77ayv/5VQD1r/+WjMkRU99e0RaK1AraYf14FqTfKmK0a9hkOaHMlpSRqRAhUgCpHkpVH8b1Lg+7G6jxF1W63fSGXkhOPuX2ryIe6/kZDk/O7uW+8pL7wFeLHbRDKtVpF89MOIIq1wxnq/qgT5Sf0XfzLDtabbFcNd8dXf5OeYniCMFCKOyV9OgpGSBmK6rzQzB241LEG36Pk1Notizp02e59DBX26g3Ehv5rgjgsfvOe2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39850400004)(376002)(396003)(136003)(6916009)(2616005)(83380400001)(2906002)(86362001)(4326008)(186003)(8676002)(38100700002)(478600001)(36756003)(6496006)(66946007)(8936002)(16526019)(66574015)(6486002)(66556008)(5660300002)(66476007)(316002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V01DbUk0VlFIc1RCRVY1TXZzeDdtdDRDeHJ6UTJKaUJ1VmFiSGFFV1pYclY3?=
 =?utf-8?B?TzN1Y3dQUjZPMEZ4cUEwVS9MSlNZZFZMczZxRkRLMG44cVdUWndrVFNyWDZ2?=
 =?utf-8?B?aUczKzZHZndvOEU3c053OEFFUzVsdEZ3WmpzTGVYa0ZkS2VJWkJQSVB2Sjgy?=
 =?utf-8?B?c2ZvTXltZC92dENscThKblF3dm1hdzFwTWxCOWpqK0lTT2ZoOXVQUzdMTmhM?=
 =?utf-8?B?R254bHB5cisrT1BlKzVNbmUvQkpPajR3bGVPd3VmdVVxVkdzTm9CbTE4VElw?=
 =?utf-8?B?REhSQzd3Z1VnQTdEOUdMK00yUXVZd1BWTS8rVGJjSHl1cmN5dmhHMWhKb1Jh?=
 =?utf-8?B?QVBIcFFjY29Xb2o3WTBYMTBNaDJlU0l0dUJkQXlyYVc5OXV5WlNRbnM5RTU0?=
 =?utf-8?B?UjBydzlnTmw0M0FvbmowMTMyWjYreUhqamVvRW5nMWlzandWTVprRGd5WjZn?=
 =?utf-8?B?cy91Yk13dEFyQ2hJblJ6Wk1ways5cTR6Y2hoRXk1bXhTakRLbzlBUG94czZq?=
 =?utf-8?B?RllyMVk0SkFBc1hMQnhweXoyQ1d5M0FUN1hCUFpCa3BSMy9KZGZwRXZtRkJQ?=
 =?utf-8?B?M1ZjWmtNQ21XdVhwZXdUR2g5b2Z2WHFTOGV5MGFSc1VSOEJndmFQZ0dzSVRn?=
 =?utf-8?B?SmNCcE4vbWgrQU9Bd3ZZaWE0K09NenhiREtJTmpZc0lDQlIxSkdkU3AyL0RJ?=
 =?utf-8?B?djU2TFBmTDlZWU5INWpxcUtRQTNXdVZMMVIzNXQwNjUvbmY3MXA0OHNpd1dp?=
 =?utf-8?B?RmtOb21ESEtjd3E5bDA1WURJNnVjZGJmNHlyaUZYRCtLK3VseFU3U3FvcHNr?=
 =?utf-8?B?R3NPZUxSYUxQV1craTA4RnNtMDYzS1Z6L0FvSGwzSGlTLzRkMmRkOUlOd3Q4?=
 =?utf-8?B?VHFJMkQ5NzRvSCtFbXg0RUljWG1RZHZkRjJqWFF3cWVHMVBoZGxVbUNkbTlh?=
 =?utf-8?B?M0lJd3FvNWdiUW5NT3g5VHhEYlcwRTFEL1JSenFZMDcxWEZPaEE1cDZZeGRG?=
 =?utf-8?B?OWh3WkE2SlorRGhjMjJBS3piQnVyNHdwRUU1NU9lbE00V1pZSmZyTHQxbHdv?=
 =?utf-8?B?UkVhdjMvK0w1L09JN3AzaTNqbVl1SzdjMWc2V0t3VW92R0MyV1NmcG80RjNv?=
 =?utf-8?B?bklhZjRiSktDNWJBWVE2eGZDVTlIQ0JCOWpUMko2eGZ1TnBraEFwLzZjdEFC?=
 =?utf-8?B?dk1OOTd5ZFo0a1RaZUdRTWNJSEw0RVpreW1wbXJZbW8xTzZEMnVKdkpmSkQy?=
 =?utf-8?B?aktSclBOWEdmRThpYm54a2N0OUlFLzdUUWVWZ1FyUFVoY1RTdUpFcG5TZnhI?=
 =?utf-8?B?MVdHQWk2U1dCd1ZwdlZZL1lrSHRGVFpQczZxWWszaS9HblM5cmxUNldVdUYy?=
 =?utf-8?B?dHMwMC9qZmMxdVRBUkE4L2JROTM5bTNmRi9tNHFCQU1sQ2NsRXF2WWZNOW13?=
 =?utf-8?B?T3B2ZzNmbHJFNTRtYng5d2s0T29EOU1Pd1Z6S0JjcUFzeWp3K3d1blBnQTFO?=
 =?utf-8?B?eDYvZEJESCtOb2hyaXFLZ2ZreHZ3dlRPbmhYY2xTZkJlNUNRSkYzaVg2c09O?=
 =?utf-8?B?M0dCanQ3QVFXMjArU1RHR2hyRnZVWGRNSWFDbk1WTXk4VXZkNXBwSlY0MjZX?=
 =?utf-8?B?OXBYSklVbW1pOC9nRDZ0SEdONVYrYTUwV3pqUjBON084b0NycERaT09EY1pG?=
 =?utf-8?B?cVZ6emNQZTJOeTdvUzNRUG5TaFJxVG5odFhxWnd1d0NhakNoZ2t4NUcwMHgz?=
 =?utf-8?B?Yk96VnhlalA2VC9MZHFJc0hIQS83MVl2RGdnUTRHL2FDSm15d24xdTRYUUpQ?=
 =?utf-8?B?cWhOWVd2QlRXV1NTWW1YMDFuWFVnaDVUcm10UXdBUER1d3oyQXFac2FMVDNV?=
 =?utf-8?Q?tjC6ffxNFywr5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9277c14a-8136-4202-41bc-08d903f9fe5f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 12:44:09.9999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5PFqXf9dg7s3mkQHeFfLntG/dAkn6EsWw5miamVYvfjme0CcpmIO8tvxeC7Rx/S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4669
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi Dan,

Dan Carpenter <dan.carpenter@oracle.com> writes:
> Thanks for the idea.  I can implement something like that in Smatch.
> I'll run the attached check over the kernel and see what it turns up.

I've only used sparse I think (make C=3D1) I need to lookup how to use Smat=
ch.

> It says that it's only checking assignments but the trick is that
> Smatch creates fake assignments in the background for passing parameters
> or returning.  So "return a ? uint_val : -ENOMEM;" will trigger an error
> message.

Sounds good.

> If there are too many false positives when I test this tonight, then I
> may make is_suspicious_int() more strict.

If that's any help, the exact bug where we hit this is currently in
fs/cifs/file.c in collect_uncached_write_data(), this line:

	ctx->rc =3D (rc =3D=3D 0) ? ctx->total_len : rc;

Hopefully it shows up in your tests.       =20

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

