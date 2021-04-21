Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE988C433B4
	for <linux-sparse@archiver.kernel.org>; Wed, 21 Apr 2021 13:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A09566141C
	for <linux-sparse@archiver.kernel.org>; Wed, 21 Apr 2021 13:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242681AbhDUNoD (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 21 Apr 2021 09:44:03 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:31884 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242691AbhDUNnq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 21 Apr 2021 09:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1619012588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rOOa6AMX+RyqJF7J7YLB+Ja4aWYy5xVxVj1Vx/betaY=;
        b=Rh/csKMy7umbSnre+OBCWVpgbJVDLRLzFqfckgY5Z+9zNbPRi4hJkPek1P0URmoIX/cSLF
        OZ4DNox0Gf/mDKa/nOa7dNNxt8oD09cnRsWGk0OAmYghXJoRvTMV1a/Fqu4xNKBZCk4/R9
        tOFr649bmKtk9gCH6/DIkAcwqKLVA1o=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2055.outbound.protection.outlook.com [104.47.14.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-21-AWMns1WRP8GYW18tI7efIw-1; Wed, 21 Apr 2021 15:43:07 +0200
X-MC-Unique: AWMns1WRP8GYW18tI7efIw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/BWJjj6zZFjD/Ykxj77PAKdZYFJZcKLWWm9CrKD3AmEk5Qlsz7HIl+LZZXes+NPhDqBn/YRLG44f30n64i6nedqM0KVLOo3RhvPAc17H4hQlf4Bm0PWtqWeBe70MylWbnSmWnpqsOTDwknVbCE9r/q5ivbYwiyNsXO+NRgMaQPP8Mubxv48hl19eaycPTUgFVvhXyCPOYtP1s7NuyAB6bD3+Woepsn/WSZ6QFFskuMS5zucrd47Oq6TQuKR3+DJJJGGq7lYXH+6Rpec3L72Ywq0KM+TxBBKxCO6DtPmzN1uDjiqul515aqNgrsJp2XKYfWCvcKIA7U+AcJZKSg5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOOa6AMX+RyqJF7J7YLB+Ja4aWYy5xVxVj1Vx/betaY=;
 b=iayc/RTBVrt9BpODTOcqq6QoflKf2VXEB36Cauex2sCNQL/UCDvWe5dntIPWykM7KRlTWw/GbFlVfPEEH7sWPxZg+aRGTm4ljND5EnIZT/06au4Z/OGrpwn7fBH1YAx0Q2xFBK5Tg7h/Wq784mG5vWcEAUFGKVs/YIZiJW5NymWbrpNpU04hC+N25tkGPpmCREPu+r5szhiIw0hOikh4XqddWHfe/k+XY6AtrWi7SAOoAo1+nx/uqxRAoT/e2aHhdfJZjMLeqgZ7zGyobT5lTiOMv1jF919j3fvWvL8jpN/PrRSStJxG057+HftB4zMOGd0RSExMkrQJRIiGaB6BKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR0401MB2400.eurprd04.prod.outlook.com (2603:10a6:800:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 21 Apr
 2021 13:43:06 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94%5]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 13:43:06 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: check idea: warn when mixing signedness in ?: operator (got
 bitten by this recently)
In-Reply-To: <20210421103036.GG1981@kadam>
References: <87wnsyzia4.fsf@suse.com> <20210420121602.GF1981@kadam>
 <87k0oxyvl3.fsf@suse.com> <20210421103036.GG1981@kadam>
Date:   Wed, 21 Apr 2021 15:43:03 +0200
Message-ID: <87eef3zrbs.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:703:7334:11df:fa3b:9968:bb7a]
X-ClientProxiedBy: ZR0P278CA0007.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::17) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:703:7334:11df:fa3b:9968:bb7a) by ZR0P278CA0007.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 13:43:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24e91e44-4820-4fd5-57be-08d904cb64ab
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2400:
X-Microsoft-Antispam-PRVS: <VI1PR0401MB240077C883FF05486A263C6DA8479@VI1PR0401MB2400.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYOu/K+UsY6wR33sKeQy8lR8QJ/O6CqwUhPDB6/5C0iIB3C7DCqaDnIzFggZe/+MdniUyU1yCuCGjYJ9yWY4SFxtFMDgAtlE4SYRfg2T8C0tOS2Q3pZnO85oPUFV58j+8X1ddHzU74+LNJmCUe4AXBG98hnXVYXScnf2o/P/s6I4YnXdsR9SRohU/sFVQWM+kOE/nmaPU1Hz2aAsXhP2nnajFmunRzjfwVVWVbrLDl4hpd+tmDy0un85diECI2lto9Tu/NtZcoOCvZquF+7s2U8EU6hScND46FfeTdUp0CwfpqQXTnCDglDM76FRSiECZX285EKhwzHpuu0WeNrtmv+3zrkJHIi9O/EvZszgQSp6FE2QDJfC8yibV81XIJRCokKIRawrxVahZnvkqRJqFeKchpX5qicpico4ppPV41I2jwkZGBK5Y9R8I/MIKzxSd6zFgcn2a0/bnh3C5jh4XFmxBLEaOb/8rY/glH2jHbIAYQ1FhUQrMDy7PjFqw74R8xpo8bN49aoV6k/HCYKWer8ziSVxzdF7uv6gX722ITVE1uHW41u+OEHmd+PlhGjXwwr+Qn/w/LdTZreP7e4gJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(366004)(376002)(136003)(2906002)(8936002)(8676002)(16526019)(4326008)(2616005)(186003)(316002)(38100700002)(6496006)(52116002)(6916009)(66946007)(478600001)(66476007)(6666004)(86362001)(5660300002)(6486002)(36756003)(66574015)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UmlzL1RZaDQyRnpNL0FjNXpRSHFsZ0NZNU1oazU1N2NTMk1JS0ZnK1VWWjhG?=
 =?utf-8?B?dmRnL0EzQWx4RGd2WCt6ZGJOeld5WU9aMmJBN0lGL1ZCeUZNSlRPRjVwVXhF?=
 =?utf-8?B?ZTBha1hnNjlWQnpiTDcyTXJ0VURoTVFaSmU5K201ZnZFRE5JWFB6N1lxdnM3?=
 =?utf-8?B?L0NEcEhJNDBnQS9jZjR2ZGxGRkFDbkg4SVNTRi81OEVVZ3d4Q1Y2ajR5RGZi?=
 =?utf-8?B?bEM2MlpMK0ZtZEYwZjZ5TjI0bEtFbDVqdWFJVzZjcFRWOUF4VzVnclRsOWF4?=
 =?utf-8?B?cTFNamxZQnErWEJVWkNxaDZ3TTBIWW4wZXRjSXhHWit5cnkycHZwTDNLNzlt?=
 =?utf-8?B?Qm9YYXlGdzVVcVpjQnZIRGpnN1RnVEJsc1E4ODk5QW9jNklvbUpUWGpWUUpH?=
 =?utf-8?B?UjFVdkxscGZLSlQ0aWpsOC9JaS9tcmo1b2pzWW4ySjM5LzQ2VUwrUnNxZm96?=
 =?utf-8?B?RTZBbHNtQ0swNVJRdFZsODJ6aDlsRnFucXZPT1A0bUpBLzdMa1BKM3RRSldU?=
 =?utf-8?B?ZTJFQTF5RkhDOVExUTNGZkM4end0VUt2TTllR0lDVklCNGNWNDZWaml5T3U1?=
 =?utf-8?B?aVhBdXE1YjEzZEM5L0NLNmpGY1NqUDVpdEhZcjVybFJGRlpEMUFsSThQckkw?=
 =?utf-8?B?UDVNUTQxYTdlZG9mRVdPNFhlMGRCS1FxRDlEdTQrSDhoZStoUG5GS0tseS9D?=
 =?utf-8?B?Ry90WnFjc1pxT3o1djR6Sytaejg1bC9tTjcrZm5uVUJjRXBLcU5XSTZzZzhJ?=
 =?utf-8?B?SWFwUWJQNlFGbmUrTk0remVnOW0wcVN2VGwyOHphY1RjSnlqY094QW82V1VZ?=
 =?utf-8?B?SVlabWMwaTBqVzE4aGJJWng4NmdPTkxSbUwvYllrRkFwOHNNWlRhWENtZDM1?=
 =?utf-8?B?OHFoSXVBejRzSkxrY295enNVUWlQQWI3dXh3blU5KzNqNG94QytHMm9tcVpV?=
 =?utf-8?B?TTVxdC9sZ2l6dGFhdmo3ZXJacXliVWZRTy90MWE0dVFoenJXbXlXb3ZXQkkr?=
 =?utf-8?B?bjQ3QWJ1SGNnVE55U0pzK2ttRCtLRzgxUyt4SkQ1UEZtUG5Ld2VKWjRNTzR5?=
 =?utf-8?B?b2dsV1JxL216MWZsQU5ZVlRwS3JTS2hvbmNmcDl1cDZwTGdKYjczNDZKYm1j?=
 =?utf-8?B?aXJzdWphN0FITlM3UzVQZXB1a1VsbzUrVTNNWC9FSWR2ZGRKZldsT1QxZW42?=
 =?utf-8?B?MmoraUhCNk1YcThRMGx0cDh1MGx1U1F1bGNOc1JhNkZmeUluVlE0cGxocTVi?=
 =?utf-8?B?S2xPdC9JVmM5QU51TkhFRlFHVm94MFR5YVVaY3BKTmVLeW5xbTdpM0UzQnB5?=
 =?utf-8?B?V2FWUVVnMklxSllROUszUmFDT3prZTR0eS92N054K0RyZkFEeG10ODY3ZlhJ?=
 =?utf-8?B?UkdMSjl3TEFYM1ZUTDYwZXVFWDFTYlh2aEtLbG1STlVMMEZFbC9uUEYyWnUr?=
 =?utf-8?B?SzdSTzNUa04zRXFod1hrenJHTTBJY092NlEzSDFFbVR1aWFlVWthOXhRSmNh?=
 =?utf-8?B?NlU0RThidlFHZHBlUFNoaHlCdklBM21xMkVPY1UrdFJvbDJoMHdHMlBadWQx?=
 =?utf-8?B?M2FsdTFwWG13bHRCL0NVc3pTYVpCbEVMNUk5NE42ckVxd0tLVlZiOHNiajlS?=
 =?utf-8?B?RUZEbHl5T3pzcExnRWRpY0pZNWRDMloxaGdqRFVNY096d2JHY0tMZCtpdlpH?=
 =?utf-8?B?ZzM5TEVOZWU3bDRiYStYZ0d6bzhRU1ZUaXVlYXZLZWt4bGkvV2tMMFBEUnd0?=
 =?utf-8?B?UWVDdmZpS01ZUXNtQ0R5Tk9iMG9LMnExUWJiK3B5STdZc3IrSURGd1czbFhV?=
 =?utf-8?B?bjVsSTBQaXlwd25HSDM0c0ZabUtQbDU4Rm1Fb0NSaVYrLzk1Q0hLN2x3MnVk?=
 =?utf-8?Q?MuSeP8Yr17fyr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e91e44-4820-4fd5-57be-08d904cb64ab
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 13:43:06.4686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9luXWo+MWdUeAFVsOKNBMzJ88ti9LVbI6qU/kdFnmQkH69VpH2xh9IOjX1YVndmN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2400
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:
> Yeah.  It finds it.  :)  It works pretty well.  The temptation is to
> ignore left shifts.  Otherwise I think I will just push this.

Great, glad to hear! I didn't check everything but these ones look like
real bugs (samples but still):

> samples/kfifo/bytestream-example.c:126 fifo_write() warn: check sign expa=
nsion for 'ret'
> samples/kfifo/bytestream-example.c:142 fifo_read() warn: check sign expan=
sion for 'ret'
> samples/kfifo/record-example.c:133 fifo_write() warn: check sign expansio=
n for 'ret'
> samples/kfifo/record-example.c:149 fifo_read() warn: check sign expansion=
 for 'ret'
> samples/kfifo/inttype-example.c:119 fifo_write() warn: check sign expansi=
on for 'ret'
> samples/kfifo/inttype-example.c:135 fifo_read() warn: check sign expansio=
n for 'ret'

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

