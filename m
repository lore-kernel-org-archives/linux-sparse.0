Return-Path: <SRS0=gthx=EM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C892C5517A
	for <linux-sparse@archiver.kernel.org>; Fri,  6 Nov 2020 19:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 055A620882
	for <linux-sparse@archiver.kernel.org>; Fri,  6 Nov 2020 19:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="YPSvcNZr";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eSzTmq+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgKFTFI (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 6 Nov 2020 14:05:08 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9632 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728191AbgKFTFG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 6 Nov 2020 14:05:06 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6Istcw008073;
        Fri, 6 Nov 2020 11:04:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=2rRDS08boh5KBUkg92e1ZF74C4HX0NwlZLs3x6ayeMo=;
 b=YPSvcNZrx0VUT/yZnKt+wgleEPRAyEO4z1IZDw5e9XqduVdG0GDJ+C9CbdRj3TtaMF/S
 31s+NUzMb9uV5bj6ygPOojFPbiRgW3sZ68rA0ILmRy3h0LpwTcoEpmkHPjULjdJTnZbK
 /XKH6nCQwHsf4Axk4k6jLjHN5gjt241YZjw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34m5r5ubwg-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 06 Nov 2020 11:04:50 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 11:04:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxyiFp5jtfwFLMlat8qsb1R4mpHzhT2CjnnAOFoFFj8MKQ5Z1qKoKf7FRY61kuHiBGwI0R81vNXeXqqOZzqRdsF5xAeq+Vkea5aZ8k4uny6dzMpIzoK1tWno2w5rBKgGY56x8L452BpbOgYZw2eHgp7aaFPF/fUyQx6Eg+EiH27E6qFq1CnKHOLTAmngUkNd7B8bvqASl3hyTbWCLu1XMGVHtCPmDctZu2knC9ZwZL6oRVmxid+VEcA5ED1jm6tdEt7M5vaW5B5e1yYGZlo4uoA7h+wPxKvqd9yRzZkj6iM+/9SRy1BfBU6Yh+j1uEDqc1c572OYF+kQ/QsFiMKWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rRDS08boh5KBUkg92e1ZF74C4HX0NwlZLs3x6ayeMo=;
 b=l+KtkH1EQlt73w/Yx9zBhJnEhQzRubkibr+DXzSw02vK4dZdUwm9qqpdkMLJuduJT/cD+d+3Gz3M1/iQY8yBr6RF4aPzCdFAoNS5a145rVcJrQZyFG0xSXlBd7D04jlin/wIewKKwb2SA9Rxomp9y6UD8K2s3ye9qVk4Zp5NM1yY6ZvpNvwCv9TTt57JaVt7n+13d+VHPiHQPLpPGj20w+blfRyfYLx3FexIqNmlVTvVCSe2RV+akLE57aRvuSJQ2gP6UJjyXUzq/AeNXWQLutGESGdOu/v+iyeLYTCfqOOl5cExpk/2fB4GveowAuN/w31Fj5Ix+EXRxrpvHMcTew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rRDS08boh5KBUkg92e1ZF74C4HX0NwlZLs3x6ayeMo=;
 b=eSzTmq+14tWRIHbPZu5jCVHXWNKhlhXWVJncT4XLUe75C+KKDMvkvVVr8EMzIzoe2mIcL797Zh69/ZfTWqmK/CI67WpbJdPbaYEpg2nr0BtCHgSngEv1FV5fkRzsCQwTYkPEODf5SmpWPhMhzSV82iKxC3maxspJEqYGy4L9J/Y=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2821.namprd15.prod.outlook.com (2603:10b6:a03:15d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Fri, 6 Nov
 2020 19:04:46 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70%6]) with mapi id 15.20.3499.030; Fri, 6 Nov 2020
 19:04:46 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: "warning: context imbalance" in kernel/bpf/hashtab.c
Thread-Topic: "warning: context imbalance" in kernel/bpf/hashtab.c
Thread-Index: AQHWs6q9iad4HwrjwkCunsxlue0A1qm6Cb0AgAABNgCAAAkKgIABSaKAgAAEQwCAABYoAA==
Date:   Fri, 6 Nov 2020 19:04:45 +0000
Message-ID: <246A7DB8-75D8-46B6-8AE4-BDACD5714EC2@fb.com>
References: <4126C08B-532F-4B6A-A3C2-9F7928EA2806@fb.com>
 <20201105211342.6mglug2a74bi5hvd@ltop.local>
 <CAHk-=wjgKzHvGYbHpJ6DJj6W73b54QqNK0LSjY-jYdU3kxhWMQ@mail.gmail.com>
 <20201105215023.wvekadtkdwgz7yim@ltop.local>
 <B8E674A7-1B84-4E64-A688-EF226A947AB3@fb.com>
 <CAHk-=wiTAFVdMCF=oADAOFwVWff2Rs1qqD1Wqj8rF0zTgbLYag@mail.gmail.com>
In-Reply-To: <CAHk-=wiTAFVdMCF=oADAOFwVWff2Rs1qqD1Wqj8rF0zTgbLYag@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:ca49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae49d089-45de-4e85-58ec-08d88286d3ba
x-ms-traffictypediagnostic: BYAPR15MB2821:
x-microsoft-antispam-prvs: <BYAPR15MB282157C1E554EA0C5850B954B3ED0@BYAPR15MB2821.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3H8vhxdOFMTLcV98dVZq4E6wUHBO6UNR9H6HIuet9NR+7bQRfKaHMWC/MpRihYORpbIXA2jSEoKYpdv+Ev1rS04oyEtuJVYAR0bdycAIJ4up1IDRnes3S6/H8BcMVR1RcQ8Dbvzxl1OeNBy1AhwPsaXbEsPqdooFBt87UY4PVQos2NYEpaMgnOZ8VS9tT234LAtBq9/8B00POuDliIUbZ7yBSuaJeYJDB5sbz5k/VJMQ7e8EuUo0NRIMw0sdaVlZmbmzzR3SStddA31hgWoFLnXl1ibhp5vLdXOw5EYXm4drrXMkq/K52tnAxO12voxFD/jAlTpb+zjHYxVil5z+GA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(136003)(396003)(39860400002)(53546011)(8676002)(76116006)(66946007)(91956017)(66476007)(66556008)(64756008)(66446008)(86362001)(6506007)(6512007)(6916009)(5660300002)(2616005)(2906002)(186003)(478600001)(83380400001)(316002)(33656002)(54906003)(8936002)(71200400001)(4326008)(36756003)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: InjSkqHEQyEquQsUiDUE73k3OAvRXqukHT8lEVwWS09Nco5/RfGVRi/aYRO8WN2YlKkWMz8pA/GjbFvtttUF4gITCqV31fYotmGSsCT/0rw/tTGkbLMTeyFoLGUocUSvrFAwCK6lXrdA7vgPgaZMwG1VOkGoKJVXHYHQBO8zwn/f/jehheKEWk0wnFCdW1K1C++jnZ7okHvib1j57oM4ATJ/ULE9o6Ks+4hTeBzGtiRUCQkgobugs04SehhSp0DwuzIX0nvIjnDK+woklsezJGIR+WQ5sBa3KlHJhZasBn0oIhPxp4/s5gfJsZHoIxxyv1oxmfBMlTi+haUmcbD+S9ANmYyZ9WCw7b1pk6xiRRq9mYOXA2zIPg2DKPUAATzqk5gQ+pzPhUi76oUucd5n7Jx8cRDMDZxmUwL9p1TSP0pjRVLF+lWNS4lyfsI3LB9xstArIdPYdilbMT3iMrk9AjwqnMr2vTd/PVqO4e2M0lkQjzj8H5ZP4ef4YHvoWVaXYRjMr9jiXqNUG/Ydcs68slNPAkdbLstZD5lj7r0+lHN/3Cgl9+tVR6xK810BRmhiqm41tr0w0lnC1tFcQ31v0Ku187l7Z0Nusx+jOIpChVFlTj+DpFcHaUUwrdPZO5h3n7MjCqeQM3lm8WidtN1ms/kWJx4M/gxOhz29pld7T1KBdrxsnn/AhWslHgeTRJEd
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4BF7728A2BA7A149BDBC710DAD826A19@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae49d089-45de-4e85-58ec-08d88286d3ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 19:04:45.9740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mdt0QCsqy9rhKwUKxDuXyoaFNc0W9uZOK4HqFWnXqjy64fvefWqbuCPbsaNmi0HEyDaskeNa0Z/yphGypmViFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2821
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_06:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=797 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011060134
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



> On Nov 6, 2020, at 9:45 AM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
> On Fri, Nov 6, 2020 at 9:30 AM Song Liu <songliubraving@fb.com> wrote:
>>=20
>> I know very little about sparse internal. But I feel this is more
>> like a minor bug.
>=20
> It's not really a bug, and the pattern you show isn't actually all
> that easy to see for a compiler.
>=20
>> Here is the simplified inlined code of htab_map_delete_elem()
>>=20
>>        if (some_condition) {
>>                ret =3D -EBUSY;
>>        } else {
>>                spin_lock();
>>                ret =3D 0;
>>        }
>=20
> So here the issue for the sparse optimizer is that while both "ret"
> and "spin_lock" is tied to "some_condition", it's not really obvious.
>=20
> A compiler would have to follow all the value analysis - and good
> compilers do that, but sparse is not a "great" compiler, it's more of
> a "solid and not horribly stupid" one.
>=20
>>        if (ret)
>>                return ret;
>=20
> So I'd really suggest you make the code more obvious - it will be more
> obvious to humans too.
>=20
> Write it as
>=20
>        if (some_condition)
>                return -EBUSY;
>        spin_lock();
>=20
> instead, and now sparse will see that obviously spin_lock() and
> "some_condition" are mutually incompatible.

Thanks for your suggestion! This pattern didn't trigger the warning.=20
We still need some work to apply this to actual code, because the lock
part is in an helper:

inline int htab_lock_bucket()
{
	if (some_condition)=20
		return -EBUSY;=09
	spin_lock();
	return 0;
}

int htab_map_delete_elem()
{
	ret =3D htab_lock_bucket();
	if (ret)
		return ret;
	[...]
}

We can probably split htab_lock_bucket() into two helpers, like

int htab_map_delete_elem()
{
	ret =3D htab_lock_is_busy();  // check some_condition
	if (ret)
		return ret;

	htab_do_lock();    // calls spin_lock()

	[...]
}

I will do more experiments with this.=20

Thanks again!
Song

