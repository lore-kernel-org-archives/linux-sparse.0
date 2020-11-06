Return-Path: <SRS0=gthx=EM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B167C2D0A3
	for <linux-sparse@archiver.kernel.org>; Fri,  6 Nov 2020 17:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80EC52078B
	for <linux-sparse@archiver.kernel.org>; Fri,  6 Nov 2020 17:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cyAtVCNg";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="dBAd8Z0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgKFRag (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 6 Nov 2020 12:30:36 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41214 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726034AbgKFRaf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 6 Nov 2020 12:30:35 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6HUBAR015401;
        Fri, 6 Nov 2020 09:30:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=pNNDMMsacSmysPDnpd0Mx17WZziC4+oeqgxc75GuJgU=;
 b=cyAtVCNgxtD1Y7hmvCHZSZeDmqhKI8KEVXM7+sAJvy+DV845dauVihL34mi6DSViA1XF
 MDtwS4fvY0owxYVOGaV7OTjlW15Z4wTtb+HS0n3x8PRY40ghrbJmdhEaXKIbQieNQaNz
 fSR+QFnWUAZy+JL6os6q7LseYjLPa4B5cmQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34nagxr56s-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 06 Nov 2020 09:30:21 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 09:30:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jR1emLdVOngTETGf95Yh+rPE0swBpg8ufbct1zHi0yRBERByvnlPdpXzoqCWYb5MBU9WD0tNJDv5LZRxIMZsVNGvOOEVznQ8qPQMzfi07R6zhobxym+ZuF6EBkebhuJiTzoyyMN6BsrNriLCpBQzswiv0CRu+SINwsFKa3MvQ0SS8DAlq33GFACiG3KZr+D3K+McHzsgoBJerYb9hNCN/1V3Xu4V3CxNuCPBos2iC3P7mcImcqoqnKjngk5uFcWw5Le5HyNxsPLZJEptjre+5fydU+kBwxWruhATOAweb84tmMVPzlH+VqHBdGiM+0TWF/7bMZ03F/8ih4+377pvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNNDMMsacSmysPDnpd0Mx17WZziC4+oeqgxc75GuJgU=;
 b=W8Qg42xkgXRD614ILJJbdYv3pE9fYbuKQzZ0pNX7YizFv+wZzh2n5/X3LaQ/TdBMtsynxBJHBkblTLcVF9kcBfll3giJdS2eFIDeyYIodF4WMrHAhSNdb6Guaim6DNK6xfOK8cXlMuRYuUa8G4Oag5XII+whHVuEFa0lGZIspEd4VzrtU56oYyj6/fN8gEtFnTxW5YBATuqG1Y3uU26gVyrK/X6xPVJ6/t6m7LCwDtXPADBq4QmejfVxiIV80fWO23w+ON2h0mR4nXeBSk3rja+tNZmYOIgX350vO0pSCzY4UgbWQvzZtzEMv+RfJ5byLIX3gJ9wf10W7WH9g5874g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNNDMMsacSmysPDnpd0Mx17WZziC4+oeqgxc75GuJgU=;
 b=dBAd8Z0xgRwDraww79JJiuM6Dp9/F33iJjIQTssQqCliT5ind8vv/xK7G+k6NGrhS96gkjGor391GUVzTqBsC5DbDO9tCXYY80P4noW23d4MwILlgyncSk6K9By0OOLSNKXSrxwxY4mYFIB0qHlVVJxkMoYYDAbga219SLSlCD8=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2696.namprd15.prod.outlook.com (2603:10b6:a03:156::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Fri, 6 Nov
 2020 17:30:12 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70%6]) with mapi id 15.20.3499.030; Fri, 6 Nov 2020
 17:30:12 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: "warning: context imbalance" in kernel/bpf/hashtab.c
Thread-Topic: "warning: context imbalance" in kernel/bpf/hashtab.c
Thread-Index: AQHWs6q9iad4HwrjwkCunsxlue0A1qm6Cb0AgAABNgCAAAkKgIABSaKA
Date:   Fri, 6 Nov 2020 17:30:12 +0000
Message-ID: <B8E674A7-1B84-4E64-A688-EF226A947AB3@fb.com>
References: <4126C08B-532F-4B6A-A3C2-9F7928EA2806@fb.com>
 <20201105211342.6mglug2a74bi5hvd@ltop.local>
 <CAHk-=wjgKzHvGYbHpJ6DJj6W73b54QqNK0LSjY-jYdU3kxhWMQ@mail.gmail.com>
 <20201105215023.wvekadtkdwgz7yim@ltop.local>
In-Reply-To: <20201105215023.wvekadtkdwgz7yim@ltop.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:ca49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61684250-183b-40a2-8df3-08d882799dc7
x-ms-traffictypediagnostic: BYAPR15MB2696:
x-microsoft-antispam-prvs: <BYAPR15MB2696F5193693660046196DEEB3ED0@BYAPR15MB2696.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xPjJVbXHxre1+3mo2UbRH9EGsmaQPV7vOj3gwT3KA3SYXgr135eFMdySWiUJPe56INFg0/oX8irZ2H1vq1uihBVB6M4KPvW1h4If/Jpcuq/pycCiiXmIeIQIB16uNpMxnjsG89282szIp64pfkohc+SXISchp9MVtqYv68DboJv8lKiTDTcnCZ8/pFroPMwauoRswqI1uq3HCTIfZtvGGEnTVhwe1jZAT27jIe7grFaejAaTdo60T9EFUPghRMLYZgi0zGoq3ZDeZwzMlG04kNIulp2yP+eJZO9gDvoNTnQXX4T8KBwFunivqX8qDVZc7a7YjWH3Xch1j59dqrh1iQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(136003)(396003)(366004)(36756003)(316002)(53546011)(86362001)(8936002)(54906003)(6506007)(91956017)(83380400001)(6486002)(66556008)(186003)(66446008)(66476007)(2906002)(66946007)(5660300002)(6512007)(478600001)(6916009)(33656002)(4326008)(64756008)(2616005)(8676002)(71200400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bS94xOBQz60MhfqKBDmAexojdN7e45WiXv4oVBniJnBJQqt8Qx0J55jqAUdodSEo2X1fMWTy5Em0zd6kX3OblKfhnF3VexWhT1B9KlkTqayblNR/DqPozvM5i3Oe1ipy32E66ufsmKd6Na63csvKAFPb8vhAj8nSmStCSyqDqKGyVIIOAu1rflbQ4+0LUuMC90iejoOmTG+wTN7f5JRy6c2dJjl2eQaV21aCFS7k3HmZss460mi+BaTzz59bMEQSdYye1UsbufRIMLSWUCiq73Wa3ABZ1Q+BCsAD2SDu0bICVBoa/uBwQEm2g7n2+XdHhHmNbkTQbaf5itrNVdSCfT9GKo1Ql3/8dk8NNayRnyCC39n3Dl/lH3JvW+Y+OgGqkM6bhwh6hArELDsAFt8+OhqNoIDBsT5oByI8cYd3jE5zHWRcnLrDR2n3T6evkNQ2woWtAVErA+DbOdYLRAtATd19HWNYJ1JHXzUDxabfEdgUvUwNF6pt6LLKzppL0QG9gCP0yTz3KqgyYVAUkB3ZyA2LdrHmH6CsZ0NlDnBKoFIy7SeLzF0/9k1ifHuSVgUgGJbHalduHJyv6MiczTbb+u8yJ18RhgJWqdCQ064NMMQZ/FNhAxmAzzwIcqvY1gqQ+WYP6Yvr3miXauVh7sy4h+idkFiFogh0hH1ospV4ebCbGi9IYAmzDtZvTLO75N7C
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FCBE7B222296B843A3034D969241A2E1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61684250-183b-40a2-8df3-08d882799dc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 17:30:12.1430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6NYE873db8AYKxozGifBQiI2NxzEEHOoEvXXhrVvLTmHU8VBShkWSfjmVeJZEh50AsuIKpDKn6/6XB2fWX0qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2696
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_06:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 mlxlogscore=831 mlxscore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



> On Nov 5, 2020, at 1:50 PM, Luc Van Oostenryck <luc.vanoostenryck@gmail.c=
om> wrote:
>=20
> On Thu, Nov 05, 2020 at 01:18:02PM -0800, Linus Torvalds wrote:
>> On Thu, Nov 5, 2020 at 1:13 PM Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>>>=20
>>> Annotations can't fix anything here. The patch [1] changes htab_lock_bu=
cket(),
>>> into conditionally taking a lock while before it took it unconditionall=
y.
>>> So, each point where its value is tested now becomes the confluence of =
2
>>> distinct paths: one with the lock taken and one with the lock not taken=
.
>>> This is what is meant by 'context imbalance'.
>>=20
>> I think the point Song makes is that if sparse did a few more
>> optimizations, it would see the context imbalance go away, because the
>> value it tests would become constant.
>=20
> It's not how I understood it, but yes, I agree. It's what I tried to
> briefly explain the in the last paragraph.
>=20
> From what I know from these situations, in most cases, simple
> 'expression' optimizations are not enough but simple forms of
> code hoisting would often anything that's needed.


Hi Luc and Linus,=20

Thanks for your comments!

I know very little about sparse internal. But I feel this is more
like a minor bug.=20

Here is the simplified inlined code of htab_map_delete_elem()

	if (some_condition) {
		ret =3D -EBUSY;
	} else {
		spin_lock();
		ret =3D 0;
	}

	if (ret)
		return ret;
+	ret =3D 0;

	[...]

	if (some_other_condition)
		ret =3D -ENOENT;
	spin_unlock();
	return ret;

When we reach the point of "+ ret =3D 0;", we will do spin_unlock()
regardless of the value of ret. So whether we know ret is definitely=20
equal to zero should not matter at all?=20

It feels like sparse knows there are two paths before "if (ret)":=20
   1) ret =3D=3D 0, we did spin_lock()
   2) ret =3D=3D -EBUSY, we didn't do spin_lock()

Then, after the "if (ret)", even without explicit "ret =3D 0;", it is=20
possible to prune path 2), but I guess sparse is not doing it, which=20
is unfortunate but not a bug. However, it seems explicit "ret =3D 0;"=20
helps sparse prune path 2), which doesn't seem right. Explicit "ret =3D 0"
should only overwrite the value of ret, but not prune any path.=20

Does this make sense?

Thanks,
Song=
