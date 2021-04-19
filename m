Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AAFC433ED
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Apr 2021 10:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F6D61165
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Apr 2021 10:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbhDSKXA (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 19 Apr 2021 06:23:00 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:60389 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238545AbhDSKW7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Apr 2021 06:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1618827704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gZdl/Wd9qdkyXCvZb5DyBvAHq/SUGeus1rz7UF1j7C4=;
        b=GGs026QvaTFsgAC81KWDx95TQVAMGwq1GV47rgc3hNu9UQPbL2zp2Zp7l3sREXxAjw7BJe
        4o0zsKS8loomtvRM8PuXjbF6QkgGKYvUjBCg6i9TJl8X+LP4S4X9BJIMdbWaSIS/fR6RaK
        Q3BgyB5Hsmh32JQgr+pDkPFIdQz654k=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2052.outbound.protection.outlook.com [104.47.10.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-33-J-TwGjK7NXeiVdD1yJ7FZg-1; Mon, 19 Apr 2021 12:21:43 +0200
X-MC-Unique: J-TwGjK7NXeiVdD1yJ7FZg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hX3J8reER4ZIZnzOsqGl6T8Ui2MsNo+KpWSuCcJ6lZ8elmYLG29NikjGm126de8p4sVOl7zdvigh0e9hoQuKM7Z5ITtA1rIw2KqevyU6ZruAN2fJIIrbTDRyu6JLRBY3QPSX6I8O7dKlcEgW/vqI7SmaDD6e2hZarKSlhB8tI7XVqN1wj5Nog/bFxBvIWXcLk0OMogGbe1KKgQrZ84L/vjEQwNnZrWrJErA0r9qnLLOBBt21TC0b402zjMrGfrfWxWNCG4g6tDBhtO9pEHz+c/RB+L5DzAXbzrIK5lJvWhN9K6BTRozTa/6ijTjfLF73+OcFtTxhhf6/WCy7extv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZdl/Wd9qdkyXCvZb5DyBvAHq/SUGeus1rz7UF1j7C4=;
 b=DcHMDguVlAFrPJhSHoM7ywPCTs4DqSJPK6+WPvBMB11boB5gpdf6Cksf6KuuF0iBEJ6/YB27XIk+yrUcTOmyk9FrpUOp32XH6+esrZQgroDKmBt3RpQcRkAchmLlVG4/x1F+i06wwjmZDnlPUQmHvXTOtIXzW/sXzLH4sJcIr+lYrXGYdPfrMqvHRdJUiV0EBQ5ENJ2yj/SNDXjEls2OVgv7u6IeK75oCY3po0Ky5lW5I9bW6nbbunpAx+Qj25gQcZkTvtzWsWKCGIGG9xO74cYzwjkVtQBtjJeMwqOczBZe33iQRRqvzZw5JAN0oGBxiHA9noK2YaA/QeLyOYBjtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VE1PR04MB7279.eurprd04.prod.outlook.com (2603:10a6:800:1a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Mon, 19 Apr
 2021 10:21:42 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94%5]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 10:21:42 +0000
From:   =?utf-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
To:     linux-sparse@vger.kernel.org
Subject: check idea: warn when mixing signedness in ?: operator (got bitten
 by this recently)
Date:   Mon, 19 Apr 2021 12:21:39 +0200
Message-ID: <87wnsyzia4.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:709:9239:9a14:7e6b:a098:d97e]
X-ClientProxiedBy: ZR0P278CA0003.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::13) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:709:9239:9a14:7e6b:a098:d97e) by ZR0P278CA0003.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 10:21:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50d8904b-eb9a-4e8c-fe7c-08d9031ced32
X-MS-TrafficTypeDiagnostic: VE1PR04MB7279:
X-Microsoft-Antispam-PRVS: <VE1PR04MB727901A1DFF5D649A23665ACA8499@VE1PR04MB7279.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3l27vR2fnyMeCKHdlY+wYxAP4FY1Vywe7hsCymdlRObxX/fzEFwo4ASzSQFmbHrZPOTYPVt2PNrh8fx+8xtOuGaaxgGr5vPYUJrE5LNzcpNrczgcfexmkmYNJxFsmgVaHXzr6Lhmy3iv34RSMCB7xku5Knt4cys9/VPhmZhpXae81vY0uBtSq6Ui8ECH7tbYAHEcoi4FOKquYe2Jb7UgiOhuXKey9GT2gxHeLYHAD9k9QM55c8Bwahbo/WyZTW7IRz0mk88KtYA45iBWbdcrONjAWFIZP3afZIr0mLtT6gjwX3hogw3kgSgPbpWmaaD1WKztpRXHsH9OuqOH6UCIDoPDQfkbkuaESpIQCtKBYzQp6njpkjR9yWlbdgn14/DxnXj9331Jwp04ezqILJ1UaRB6JB9b01965n9lkaRwWSpGWxERcj7Yzrg7e/Ho9mHxkb13EgaLRVEzJF2IWJDPlmjatwOJUYfcynq50sXeGtVhIEUaU3qZvn+/qTjXd39UsB+3qUUR9iXjhK2eDlKNvEUqvGlgPXTQPiDw0Z5GAFkw57pGY1OLaQVnHIZ3Z0wFQi/bsztq8C5yNov29GCXFN1amSmNDsko3tUQEqN6mk9+uiyrFflFS4FBFp/4f9umu0y1djW5tVzgyg0cJlsqk4I52aJFRrvM552/K4RHSE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39850400004)(136003)(366004)(8676002)(2906002)(38100700002)(478600001)(186003)(52116002)(6916009)(6486002)(966005)(2616005)(5660300002)(36756003)(8936002)(6496006)(86362001)(66946007)(66574015)(316002)(66476007)(16526019)(66556008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MDFjK3BiRkVRQW5NWndsK3dwMVNVTDhQUlJ3QmFreGROdFp6ZUpWRExsVWw2?=
 =?utf-8?B?MUdRZ3lSZTlYTVdhNW9kNkswa2tjZFBYYW9xZitqTHdRVHR4ZldWd2V5R1dS?=
 =?utf-8?B?Nkc2S1pjN3R2Q3pMRjRtMWJJd1MxbzJoM2p6c3krNm9UMFRLUFhFVTdScWFP?=
 =?utf-8?B?c3dWdVdvU3owMHlXUVZ4TzV1Ym9QWG5QWnpUNFYrWDBrRkp0WmQrVHZFZ25u?=
 =?utf-8?B?UTFkSUhwSDYvbHAybVFQckJON0ZPbVVBb0JWWEFtUUo2QkZjSi9VZUMzWVly?=
 =?utf-8?B?VzdMd1o3M3l3alZ3RGgyMm9QYmRRbE9LMG5lTHh4VXExckFEQWlIV2dXWE9Q?=
 =?utf-8?B?TE4rQUpEQXZjaEhlNVYvMnJiV0JlbDdYUjAyNDFncTk0eUVIZ0FDeHIyODFn?=
 =?utf-8?B?ZlBDVVRkVXpORlV5RUxydkhNRmZGZ3M4T2RYdjdML2RKbXYrNWxSRzE2anND?=
 =?utf-8?B?cGtFRkdrak5xUHVHNmZETjVQNW5PNU9IVXhBMk5sVnJoL2JrQjNVdTI0dVlF?=
 =?utf-8?B?dUNuN09vMzVYbUNzMzY4L04velc1ekQrT0Mxb0J4dzNIN2FScVh4WDZaVFJD?=
 =?utf-8?B?ZGhuUFVTZkJ5SlJGcWhMMjFKNUNuV0hlNmxaWC9kSzUwelR5QVZZalBoZzlX?=
 =?utf-8?B?a0JnUGFiVTZ0TzNaV1hFUSsrMEFpY1V1WVQ1ZWdxMnVybUdnM21QLzd4TERp?=
 =?utf-8?B?ZGQ0SFdVZU1nQjNtU0VyVUExK0FmWFhuVWxLWUErOGV6SnNKdndqbWpYRDln?=
 =?utf-8?B?L29CQTRnb1hRS2ZYZWhzZkdDMXFWMjZqaGRoTGE4bFlZVXMwdndCd0J3T1Vm?=
 =?utf-8?B?K25VWWtoN3JlYTRKaXVMVHpLcGNVaUduTWY3eGxTNytTNUhLR095ZjlxQWp3?=
 =?utf-8?B?T0sxTXZielNuZkpueTVYLzI4ZGRPcFpiekhzdmxYazV6VDR5OUlDK1RnQVQr?=
 =?utf-8?B?NUZ5UGNOY3ViRU8zajVWSURvN0RrMGY4eUM5ZjlxR1ZBRnhhZEh1Njhpdm83?=
 =?utf-8?B?elJUT1ZNc2NrbWtFWElseHRMNXFCbFdSZWhuV0t0R0tSZm8yeE8xUzlZdWdT?=
 =?utf-8?B?cGVianN1Q1hVRkg5b0hvMmtLbk9TMmxYcjlzQXFNTmU5bm1oMlRWZTJiTU9K?=
 =?utf-8?B?TEErcTBKNE5NVnk3VHVMUmo3eWZ6d2RxOE1ocTJUaklzM2o0TzA5Z1h1a21a?=
 =?utf-8?B?OGpKZ2ZVQTJDTTNDbmhEU1BqWnUzdXQ5bEdDNDN3NmI0REZoTkx5aUgwcFpM?=
 =?utf-8?B?WnBHb1lBZUpmd3FrVlM1YXhpNDZNUlRUQzFuVXJjTURKenY1Wld4eW1aVmxo?=
 =?utf-8?B?ejg2Zms3aEZRRGgybFRZRzRxTGdEbXoyeWpxV3JaY2ttZjUrRE5yTmxPdUZw?=
 =?utf-8?B?dWUxQWRvc1laWHlINHZjamc1VDJDWm1PZllzM1VmUEx5NDJNRDZ2citpQUJY?=
 =?utf-8?B?bmZEN2UxWHhkeVBXUVZNTC84RHBsK005azBkWnRkYXJXSUY1eGpCdkUzK0p3?=
 =?utf-8?B?eFNTVlhGWituMnJyN3cwTVlDSUl5cFlNOWk5Qm44YmdadnNYUk1WV3FvdUpC?=
 =?utf-8?B?dzZlYklnNHBZOHRuMmVuYVFNSSszVHVFeFJhVGFDNnJPQTZtYnc5bmpOc2Vs?=
 =?utf-8?B?bU1QNkdIN0R6TnVMMTMxY3JQQ0RpME82REUwbVdtdGJNUW9vOWhmamk5Y3VF?=
 =?utf-8?B?T0k4eHNCQXpBRmFTTnJseEdPVWV5dVRpb290cEpybVhUNjd0b0NvamwxVFQ1?=
 =?utf-8?B?dVZURk1GQmtUUDh6dE54UXZuNmtLMVdTVFc3K0VyQUFtQjlYaFRod1F4QWh6?=
 =?utf-8?B?ZXR2Ym1pTXlmeU13RzdmZVVhOUJ0NlFna3pBMWpXT0paQVVXL0NlTVh5WmlP?=
 =?utf-8?Q?gsjCQwhDtzX7g?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d8904b-eb9a-4e8c-fe7c-08d9031ced32
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 10:21:42.4198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yhOrzwyAXPE95hvBI8XauKMRblInGT5ZKyRYUoL+y3TyYFTPFGsHmn9jRePORgl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7279
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi,

If the <then> and <else> expression in the ?: ternary operator have
different signedness they will both be implicitely casted to unsigned.

When the result is stored in a variable with a storage capable of
holding both values, this is very unexpected. Consider this example:

    int rc =3D -1;
    unsigned int foo =3D 123;
    long x =3D y ? foo : rc;

If one of the branch of the ?: is unsigned, then the compiler will cast
both branch to unsigned _before_ storing it in x. Despite long being
able to store INT_MIN, INT_MAX, UINT_MAX (assuming 64b long/32b int).

So if y is 0, it's basically doing

    long x =3D (long)((unsigned int)-1);

Which will result in storing 0x00000000ffffffff (4294967295) instead of
expected 0xffffffffffffffff (-1).

I thought we hit some sort of weird compiler bug but after reducing the
problem to the simple example above and trying it GCC, clang, ICC and
MSVC they all do the same thing: https://godbolt.org/z/P5Ts7o1df

So it is most likely a C quirk. Standard reads 6.5.15. 5)
> If both the second and third operands have arithmetic type, the result
> type that would be determined by the usual arithmetic conversions, were
> they applied to those two operands, is the type of the result.

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

