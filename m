Return-Path: <SRS0=cI6h=EL=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75785C4741F
	for <linux-sparse@archiver.kernel.org>; Thu,  5 Nov 2020 19:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5ADD20728
	for <linux-sparse@archiver.kernel.org>; Thu,  5 Nov 2020 19:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CTOM5MUJ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ksMPySbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgKETfN (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 5 Nov 2020 14:35:13 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42792 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726996AbgKETfN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 5 Nov 2020 14:35:13 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A5JQMSv017362;
        Thu, 5 Nov 2020 11:34:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : mime-version; s=facebook;
 bh=NI9lbeUQl4fIs/rSOtNx/fcvX1N8eMprr3iCnMrbsjk=;
 b=CTOM5MUJB0vmzPQe+wyjKjxyLdrXYJEQaYWbJC2CRrIvuIxdSpji1MQH+8q0bX8JR++5
 uWZIdAjte3scHjbn70RKsksfo5ED0jskikBdn5IQH2UhQrzb1YTshjhc4WZY8X3BsJzK
 YRA9mbnWzLyD48xl7H3xfP3+cmWjcgGAidM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34m5rfd9yy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Nov 2020 11:34:57 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 11:34:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7J9J1Xsw9WSrzgGZiFYANHtiBbJRFraGxmrl27JNcq7gONt1+BwDz+6+6aT7Wtlt/EEmH83iOA9tuJiSN/Vt8ROd60glFZVszxvVhtb8Sbqay5u16ogfoqmXgjn5TUf/bknKGVqvG6Dx18/fcea6uNviOTtJW71rDp/n0Nk1aUQ0StjX2jw6lcjR63x82Hgtyuj0CpIS+p2GFwp+e2ApSRXgV5I5HTDFp0durSqNu+t6fI8PTlEENxtBHd2QdczZdtd1vu7EAL9gKsVT/2jUGjyOiO9nPd7oR2z0Ys8iAzFIp069v6e9nGr4N1z3qnyBongR0blBMcEdwnAmc7bdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NI9lbeUQl4fIs/rSOtNx/fcvX1N8eMprr3iCnMrbsjk=;
 b=CSQC8t16xV9D+3cgD1/DJRkzHk4r2CSOOyDSLdrHi6l4SYrxTGhC54j8WuEJsBSPX0KC6qeL68kgo5UM8yquoBZWVNno8s2S+P6MVEEevYFcdGqhej0ktjb3v+FqGRl++HJYHEzRT5WxCvK5jBDKwKFmRG129VWxJbvYqvZ4eX6FSF3gX2iPRSwkalnlBw1Eg+ltVY19CB9cJcfqszntujQpmin1UpyrcfEwzzGX3L+shBMCfUkGb2oR97MQgNVLNO7jnXCP++GRpfqTfMU7jM30nmPXyZegx07Ec1Jz5s9SjTPfqucW/pMPIKoEoRee1W2Y02eKlydTJ4OqxhiCHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NI9lbeUQl4fIs/rSOtNx/fcvX1N8eMprr3iCnMrbsjk=;
 b=ksMPySbTXd5x7O4VIXYq/Zs+eC7LvrvoOs5fbybuKihXPq7EqEMEAP9JrJq2GNkxQEX//KiEtEpqx2OHY78vKQUn6gYzEXPdLYca8KxCdiiKCjyI0W0gCcY46WZMwM46rBZhiOwb/IifOfdAOTqeXrcc1Fl1LX3751qVaGKKSaM=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 5 Nov
 2020 19:34:55 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70%6]) with mapi id 15.20.3499.030; Thu, 5 Nov 2020
 19:34:55 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        "Luc Van Oostenryck" <luc.vanoostenryck@gmail.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: "warning: context imbalance" in kernel/bpf/hashtab.c
Thread-Topic: "warning: context imbalance" in kernel/bpf/hashtab.c
Thread-Index: AQHWs6q9WpIWjZFY8k6fNpVGaj5m4w==
Date:   Thu, 5 Nov 2020 19:34:55 +0000
Message-ID: <4126C08B-532F-4B6A-A3C2-9F7928EA2806@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:ca49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 510ee55a-3295-42fc-d184-08d881c1dfaa
x-ms-traffictypediagnostic: BYAPR15MB4119:
x-microsoft-antispam-prvs: <BYAPR15MB4119EDE052D5AF4CC03749D0B3EE0@BYAPR15MB4119.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xJ3AAkJmr/JdUJuJWe4dhwVy3xLQqupaRv86hQaARagF1twsWIFQwa4hU+Y+OZQIa7Hu/8rI7AqfyLQ5G1UQPhEt01t9XKvnn6DGMHC+VVMR/+/bwJ/m9HuVE7tc1/tRL+Fgb3RqGZoKe7t/QaNJbdZVG65Dx6zFvHLirjCDMf/KAbULcLbb+wtqm6VDrYnxL35vaIT09FkKeS6d8WIvDk047tOuF/iQW3w4gF3EZahpBPwi+WDCc42vjLdyRaaS3cR/k0/p0tNBqXj54bO1BfHZspjDYcaIw7CHGjRX4BAq35xOOvBwBLkfZE+0o4RVk5x24J/7DNRYCbgdUurw3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(136003)(396003)(39860400002)(86362001)(8936002)(36756003)(2906002)(4326008)(6512007)(6486002)(5660300002)(2616005)(8676002)(71200400001)(76116006)(83380400001)(478600001)(54906003)(66616009)(64756008)(66476007)(110136005)(66556008)(6506007)(66946007)(99936003)(33656002)(66446008)(316002)(91956017)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Kq3GCn9e9OeH0R/jyqiFtSz5uOeXHTRnAbzuv3vkIgnqnHltw6cwSyE8jCVuy1dxDFJhsdVrnvgtPx705lB7W6IqYAczcb6vAUx8taPGCCSH2GWeEm3NCQhmloHBAvGSz1gWTOhLIi5dW3ib6PBCOo+fqOcU11kQ3SNq/AV1ur3IYh6wFRgxYAKI4u6tDmtQRHKMYqfqRnjz6wxdYPiHr0rviMEkC3huiQIdEgMApTz95bSR5Ewri8XwnWF4NSjUGKnnr0f4cuq+s2rd7+VlotGs6QDhNa/fhv679zFpmUD8mKIkH+IKMtmx4lJwJr0oXCkJamQYLQE4LGuLX+rm5fBk0eU5fcFS36mpYgqeDCuj+xh6apX2VN/Eb/HNFkqLKB1bvrHYvdVOu0K9Cz5tRhv3eFEZ2DcehpKj5g25nO9LP8kouTgEE9EKzQXEk5Ahe1KFbY1TCO+zViJ8lqs+md4/HID5nPDazDEoUBNCK/UW8f0T01nWZO624eFXKWsVEFGKj4cdItju8IFbLOSp/0gXjDxpm0NVhnbHA1y7zBjmZqMQsd5EoeGMtmDDeJ6nmgVTHgbQSPvU5ABxe8a4hnp6loujtRcxsCftU9hRHIoA1T8vU+eJygp9tzAKVULvlo6cdq8HjisnS5WzLRuN0nIb0awcU6MT+lLjhd9MkdmruOXN5j+RYVvYRhmnnSnw
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
        boundary="_002_4126C08B532F4B6AA3C29F7928EA2806fbcom_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510ee55a-3295-42fc-d184-08d881c1dfaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 19:34:55.3330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmZlxaUsAPzcbG09wFs5SUQKJ9lZX54aM+oBZ98YmhbxFPpYLGGo0uVyUkZyIJaXeXgDkpXlBZSDD+ejfNsUow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4119
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_14:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=900 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011050125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

--_002_4126C08B532F4B6AA3C29F7928EA2806fbcom_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A47CE958309DB41B6F07DEDCD69E248@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

Hi,=20

We are trying to fix some sparse warning in kernel/bpf/hashtab.c (in bpf-ne=
xt tree).=20
The sparse I use was v0.6.3-76-gf680124b.=20

These new warnings are introduced by [1]. Before [1], hashtab.c got

[...]
kernel/bpf/hashtab.c:2089:19: error: subtraction of functions? Share your d=
rugs
kernel/bpf/hashtab.c:1421:9: warning: context imbalance in '__htab_map_look=
up_and_delete_batch' - different lock contexts for basic block
kernel/bpf/hashtab.c: note: in included file (through include/linux/workque=
ue.h, include/linux/bpf.h):
./include/linux/rcupdate.h:693:9: warning: context imbalance in 'bpf_hash_m=
ap_seq_find_next' - unexpected unlock
./include/linux/rcupdate.h:693:9: warning: context imbalance in 'bpf_hash_m=
ap_seq_stop' - unexpected unlock

With [1], we got a few more warnings:

[...]
kernel/bpf/hashtab.c:2141:19: error: subtraction of functions? Share your d=
rugs
kernel/bpf/hashtab.c:1292:27: warning: context imbalance in 'htab_map_delet=
e_elem' - unexpected unlock
kernel/bpf/hashtab.c:1325:27: warning: context imbalance in 'htab_lru_map_d=
elete_elem' - unexpected unlock
kernel/bpf/hashtab.c: note: in included file (through include/linux/workque=
ue.h, include/linux/bpf.h):
./include/linux/rcupdate.h:693:9: warning: context imbalance in '__htab_map=
_lookup_and_delete_batch' - unexpected unlock
./include/linux/rcupdate.h:693:9: warning: context imbalance in 'bpf_hash_m=
ap_seq_find_next' - unexpected unlock
./include/linux/rcupdate.h:693:9: warning: context imbalance in 'bpf_hash_m=
ap_seq_stop' - unexpected unlock

So htab_map_delete_elem() and htab_lru_map_delete_elem() got new warnings, =
and=20
__htab_map_lookup_and_delete_batch() got a slightly different warning.=20

After trying different annotations, including the attached foo.diff by Dani=
el,
we found the simplest fix was something like:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 8< =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=20
diff --git i/kernel/bpf/hashtab.c w/kernel/bpf/hashtab.c
index 23f73d4649c9c..faad2061f1167 100644
--- i/kernel/bpf/hashtab.c
+++ w/kernel/bpf/hashtab.c
@@ -1279,6 +1279,7 @@ static int htab_map_delete_elem(struct bpf_map *map, =
void *key)
        ret =3D htab_lock_bucket(htab, b, hash, &flags);
        if (ret)
                return ret;
+       ret =3D 0;

        l =3D lookup_elem_raw(head, hash, key, key_size);

@@ -1314,6 +1315,7 @@ static int htab_lru_map_delete_elem(struct bpf_map *m=
ap, void *key)
        ret =3D htab_lock_bucket(htab, b, hash, &flags);
        if (ret)
                return ret;
+       ret =3D 0;

        l =3D lookup_elem_raw(head, hash, key, key_size);

@@ -1476,6 +1478,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *ma=
p,
                ret =3D htab_lock_bucket(htab, b, batch, &flags);
                if (ret)
                        goto next_batch;
+               ret =3D 0;
        }

        bucket_cnt =3D 0;

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 8< =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=20

These three "ret =3D 0;" make the sparse warning back to before [1]. Howeve=
r, these
don't really make sense, as we know ret must be zero after the if clause. S=
o it
looks like a bug in sparse. Please help us look into this issue.=20

Also, there are a few similar warnings from hashtab.c. Please give us guida=
nce on=20
how to fix them properly.=20

Thanks in advance,
Song

[1] commit 20b6cc34ea74 ("bpf: Avoid hashtab deadlock with map_locked")


--_002_4126C08B532F4B6AA3C29F7928EA2806fbcom_
Content-Type: application/octet-stream; name="foo.diff"
Content-Description: foo.diff
Content-Disposition: attachment; filename="foo.diff"; size=3884;
	creation-date="Thu, 05 Nov 2020 19:34:55 GMT";
	modification-date="Thu, 05 Nov 2020 19:34:55 GMT"
Content-ID: <C18BA3D3DB1F3B4AAA78CDCC8C453D26@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvaGFzaHRhYi5jIGIva2VybmVsL2JwZi9oYXNodGFiLmMN
CmluZGV4IDIzZjczZDQ2NDljOS4uMWVkMjU0Nzg2M2ZjIDEwMDY0NA0KLS0tIGEva2VybmVsL2Jw
Zi9oYXNodGFiLmMNCisrKyBiL2tlcm5lbC9icGYvaGFzaHRhYi5jDQpAQCAtMTU4LDExICsxNTgs
MTUgQEAgc3RhdGljIHZvaWQgaHRhYl9pbml0X2J1Y2tldHMoc3RydWN0IGJwZl9odGFiICpodGFi
KQ0KIHN0YXRpYyBpbmxpbmUgaW50IGh0YWJfbG9ja19idWNrZXQoY29uc3Qgc3RydWN0IGJwZl9o
dGFiICpodGFiLA0KIAkJCQkgICBzdHJ1Y3QgYnVja2V0ICpiLCB1MzIgaGFzaCwNCiAJCQkJICAg
dW5zaWduZWQgbG9uZyAqcGZsYWdzKQ0KKwlfX2FjcXVpcmVzKCZiLT5yYXdfbG9jaykgX19hY3F1
aXJlcygmYi0+bG9jaykNCiB7DQogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQogDQogCWhhc2ggPSBo
YXNoICYgSEFTSFRBQl9NQVBfTE9DS19NQVNLOw0KIA0KKwlfX2FjcXVpcmUoJmItPnJhd19sb2Nr
KTsNCisJX19hY3F1aXJlKCZiLT5sb2NrKTsNCisNCiAJbWlncmF0ZV9kaXNhYmxlKCk7DQogCWlm
ICh1bmxpa2VseShfX3RoaXNfY3B1X2luY19yZXR1cm4oKihodGFiLT5tYXBfbG9ja2VkW2hhc2hd
KSkgIT0gMSkpIHsNCiAJCV9fdGhpc19jcHVfZGVjKCooaHRhYi0+bWFwX2xvY2tlZFtoYXNoXSkp
Ow0KQEAgLTE4Miw4ICsxODYsMTMgQEAgc3RhdGljIGlubGluZSBpbnQgaHRhYl9sb2NrX2J1Y2tl
dChjb25zdCBzdHJ1Y3QgYnBmX2h0YWIgKmh0YWIsDQogc3RhdGljIGlubGluZSB2b2lkIGh0YWJf
dW5sb2NrX2J1Y2tldChjb25zdCBzdHJ1Y3QgYnBmX2h0YWIgKmh0YWIsDQogCQkJCSAgICAgIHN0
cnVjdCBidWNrZXQgKmIsIHUzMiBoYXNoLA0KIAkJCQkgICAgICB1bnNpZ25lZCBsb25nIGZsYWdz
KQ0KKwlfX3JlbGVhc2VzKCZiLT5yYXdfbG9jaykgX19yZWxlYXNlcygmYi0+bG9jaykNCiB7DQog
CWhhc2ggPSBoYXNoICYgSEFTSFRBQl9NQVBfTE9DS19NQVNLOw0KKw0KKwlfX3JlbGVhc2UoJmIt
PnJhd19sb2NrKTsNCisJX19yZWxlYXNlKCZiLT5sb2NrKTsNCisNCiAJaWYgKGh0YWJfdXNlX3Jh
d19sb2NrKGh0YWIpKQ0KIAkJcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmItPnJhd19sb2Nr
LCBmbGFncyk7DQogCWVsc2UNCkBAIC03MzEsOCArNzQwLDExIEBAIHN0YXRpYyBib29sIGh0YWJf
bHJ1X21hcF9kZWxldGVfbm9kZSh2b2lkICphcmcsIHN0cnVjdCBicGZfbHJ1X25vZGUgKm5vZGUp
DQogCWhlYWQgPSAmYi0+aGVhZDsNCiANCiAJcmV0ID0gaHRhYl9sb2NrX2J1Y2tldChodGFiLCBi
LCB0Z3RfbC0+aGFzaCwgJmZsYWdzKTsNCi0JaWYgKHJldCkNCisJaWYgKHJldCkgew0KKwkJX19y
ZWxlYXNlKCZiLT5yYXdfbG9jayk7DQorCQlfX3JlbGVhc2UoJmItPmxvY2spOw0KIAkJcmV0dXJu
IGZhbHNlOw0KKwl9DQogDQogCWhsaXN0X251bGxzX2Zvcl9lYWNoX2VudHJ5X3JjdShsLCBuLCBo
ZWFkLCBoYXNoX25vZGUpDQogCQlpZiAobCA9PSB0Z3RfbCkgew0KQEAgLTEwMTMsOCArMTAyNSwx
MSBAQCBzdGF0aWMgaW50IGh0YWJfbWFwX3VwZGF0ZV9lbGVtKHN0cnVjdCBicGZfbWFwICptYXAs
IHZvaWQgKmtleSwgdm9pZCAqdmFsdWUsDQogCX0NCiANCiAJcmV0ID0gaHRhYl9sb2NrX2J1Y2tl
dChodGFiLCBiLCBoYXNoLCAmZmxhZ3MpOw0KLQlpZiAocmV0KQ0KKwlpZiAocmV0KSB7DQorCQlf
X3JlbGVhc2UoJmItPnJhd19sb2NrKTsNCisJCV9fcmVsZWFzZSgmYi0+bG9jayk7DQogCQlyZXR1
cm4gcmV0Ow0KKwl9DQogDQogCWxfb2xkID0gbG9va3VwX2VsZW1fcmF3KGhlYWQsIGhhc2gsIGtl
eSwga2V5X3NpemUpOw0KIA0KQEAgLTEwOTQsOCArMTEwOSwxMSBAQCBzdGF0aWMgaW50IGh0YWJf
bHJ1X21hcF91cGRhdGVfZWxlbShzdHJ1Y3QgYnBmX21hcCAqbWFwLCB2b2lkICprZXksIHZvaWQg
KnZhbHVlLA0KIAltZW1jcHkobF9uZXctPmtleSArIHJvdW5kX3VwKG1hcC0+a2V5X3NpemUsIDgp
LCB2YWx1ZSwgbWFwLT52YWx1ZV9zaXplKTsNCiANCiAJcmV0ID0gaHRhYl9sb2NrX2J1Y2tldCho
dGFiLCBiLCBoYXNoLCAmZmxhZ3MpOw0KLQlpZiAocmV0KQ0KKwlpZiAocmV0KSB7DQorCQlfX3Jl
bGVhc2UoJmItPnJhd19sb2NrKTsNCisJCV9fcmVsZWFzZSgmYi0+bG9jayk7DQogCQlyZXR1cm4g
cmV0Ow0KKwl9DQogDQogCWxfb2xkID0gbG9va3VwX2VsZW1fcmF3KGhlYWQsIGhhc2gsIGtleSwg
a2V5X3NpemUpOw0KIA0KQEAgLTExNTAsOCArMTE2OCwxMSBAQCBzdGF0aWMgaW50IF9faHRhYl9w
ZXJjcHVfbWFwX3VwZGF0ZV9lbGVtKHN0cnVjdCBicGZfbWFwICptYXAsIHZvaWQgKmtleSwNCiAJ
aGVhZCA9ICZiLT5oZWFkOw0KIA0KIAlyZXQgPSBodGFiX2xvY2tfYnVja2V0KGh0YWIsIGIsIGhh
c2gsICZmbGFncyk7DQotCWlmIChyZXQpDQorCWlmIChyZXQpIHsNCisJCV9fcmVsZWFzZSgmYi0+
cmF3X2xvY2spOw0KKwkJX19yZWxlYXNlKCZiLT5sb2NrKTsNCiAJCXJldHVybiByZXQ7DQorCX0N
CiANCiAJbF9vbGQgPSBsb29rdXBfZWxlbV9yYXcoaGVhZCwgaGFzaCwga2V5LCBrZXlfc2l6ZSk7
DQogDQpAQCAtMTIxNSw4ICsxMjM2LDExIEBAIHN0YXRpYyBpbnQgX19odGFiX2xydV9wZXJjcHVf
bWFwX3VwZGF0ZV9lbGVtKHN0cnVjdCBicGZfbWFwICptYXAsIHZvaWQgKmtleSwNCiAJfQ0KIA0K
IAlyZXQgPSBodGFiX2xvY2tfYnVja2V0KGh0YWIsIGIsIGhhc2gsICZmbGFncyk7DQotCWlmIChy
ZXQpDQorCWlmIChyZXQpIHsNCisJCV9fcmVsZWFzZSgmYi0+cmF3X2xvY2spOw0KKwkJX19yZWxl
YXNlKCZiLT5sb2NrKTsNCiAJCXJldHVybiByZXQ7DQorCX0NCiANCiAJbF9vbGQgPSBsb29rdXBf
ZWxlbV9yYXcoaGVhZCwgaGFzaCwga2V5LCBrZXlfc2l6ZSk7DQogDQpAQCAtMTI3Nyw4ICsxMzAx
LDExIEBAIHN0YXRpYyBpbnQgaHRhYl9tYXBfZGVsZXRlX2VsZW0oc3RydWN0IGJwZl9tYXAgKm1h
cCwgdm9pZCAqa2V5KQ0KIAloZWFkID0gJmItPmhlYWQ7DQogDQogCXJldCA9IGh0YWJfbG9ja19i
dWNrZXQoaHRhYiwgYiwgaGFzaCwgJmZsYWdzKTsNCi0JaWYgKHJldCkNCisJaWYgKHJldCkgew0K
KwkJX19yZWxlYXNlKCZiLT5yYXdfbG9jayk7DQorCQlfX3JlbGVhc2UoJmItPmxvY2spOw0KIAkJ
cmV0dXJuIHJldDsNCisJfQ0KIA0KIAlsID0gbG9va3VwX2VsZW1fcmF3KGhlYWQsIGhhc2gsIGtl
eSwga2V5X3NpemUpOw0KIA0KQEAgLTEzMTIsOCArMTMzOSwxMSBAQCBzdGF0aWMgaW50IGh0YWJf
bHJ1X21hcF9kZWxldGVfZWxlbShzdHJ1Y3QgYnBmX21hcCAqbWFwLCB2b2lkICprZXkpDQogCWhl
YWQgPSAmYi0+aGVhZDsNCiANCiAJcmV0ID0gaHRhYl9sb2NrX2J1Y2tldChodGFiLCBiLCBoYXNo
LCAmZmxhZ3MpOw0KLQlpZiAocmV0KQ0KKwlpZiAocmV0KSB7DQorCQlfX3JlbGVhc2UoJmItPnJh
d19sb2NrKTsNCisJCV9fcmVsZWFzZSgmYi0+bG9jayk7DQogCQlyZXR1cm4gcmV0Ow0KKwl9DQog
DQogCWwgPSBsb29rdXBfZWxlbV9yYXcoaGVhZCwgaGFzaCwga2V5LCBrZXlfc2l6ZSk7DQogDQpA
QCAtMTQ3NCw4ICsxNTA0LDExIEBAIF9faHRhYl9tYXBfbG9va3VwX2FuZF9kZWxldGVfYmF0Y2go
c3RydWN0IGJwZl9tYXAgKm1hcCwNCiAJLyogZG8gbm90IGdyYWIgdGhlIGxvY2sgdW5sZXNzIG5l
ZWQgaXQgKGJ1Y2tldF9jbnQgPiAwKS4gKi8NCiAJaWYgKGxvY2tlZCkgew0KIAkJcmV0ID0gaHRh
Yl9sb2NrX2J1Y2tldChodGFiLCBiLCBiYXRjaCwgJmZsYWdzKTsNCi0JCWlmIChyZXQpDQorCQlp
ZiAocmV0KSB7DQorCQkJX19yZWxlYXNlKCZiLT5yYXdfbG9jayk7DQorCQkJX19yZWxlYXNlKCZi
LT5sb2NrKTsNCiAJCQlnb3RvIG5leHRfYmF0Y2g7DQorCQl9DQogCX0NCiANCiAJYnVja2V0X2Nu
dCA9IDA7DQo=

--_002_4126C08B532F4B6AA3C29F7928EA2806fbcom_--
