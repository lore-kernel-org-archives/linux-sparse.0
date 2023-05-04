Return-Path: <linux-sparse-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CB2C77B78
	for <linux-sparse@archiver.kernel.org>; Thu,  4 May 2023 08:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjEDICT (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 4 May 2023 04:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjEDIBx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 4 May 2023 04:01:53 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5893C28
        for <linux-sparse@vger.kernel.org>; Thu,  4 May 2023 01:01:44 -0700 (PDT)
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 72B693F467
        for <linux-sparse@vger.kernel.org>; Thu,  4 May 2023 08:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683187302;
        bh=ziGqou2qS6bNirqwUlZFHFaaArJG98y+ApUyw5AFzQU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=q2s+EeBmbOGfAp8zcLNBBK5kwb45To1Z5GBYce0SQKMsG+Mo/K3pEbJmewlQUVz4F
         ehlnEmEHBcFuXl14XBqAJdJlk+SjR3Q40/5eQfmLjDVIXxZ90htbB0L3mud99b9zB0
         FjMtYO6YmWzNSvNN+IXB2zf3bqAeE4Go04/SCO9imLyyJlFQW+2EBkpGqCYeG9y3Vx
         fqo+uQO+3Qdy9yFRx0CdepT2RYeUxEksMnF9DmzWxS+46qO08ps6XxVfhH6h08CuSD
         e+el2oDyp3+PxbZydojzw4fvFxgg59WaxEyKvvTl70rZ47oCzOQjcuRx+Mq5xc5KBl
         aKVjiPfZyM4yg==
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-b9e027509c3so25483276.0
        for <linux-sparse@vger.kernel.org>; Thu, 04 May 2023 01:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187300; x=1685779300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ziGqou2qS6bNirqwUlZFHFaaArJG98y+ApUyw5AFzQU=;
        b=HQfO5AxxmzD+dfc5renizRbGUG2gwpCtVTG1rRuvnW4cxa/+eeOYqzeZYip37p0SfE
         luUbwOJyjoIeO0wtBBEgOKpSLcao8Fqf+3b9rq2RXEFDjzfvo72yNNpLK18o04W9zFhZ
         JxFajeEzWPDoWwrafwkdaA/dStuFfiDMpNEExoEhPf4e5V07FJmolXgRZUyZ5cbHwPXz
         dDYaQdatlKRcs5ynfLiuZB7Beh5idfYGUJknfr0o+485m/Tm2KLMb33KwKFq/wCQpV+e
         7I33hitVIYuGXAqM/QYwuycW4G8S4s8XNSpvWJBsUbATP+UaRTGkBTkPlAMgsiTUFNmf
         HcBw==
X-Gm-Message-State: AC+VfDyiyV79VoU/91tLhXtkEI7NNKroeegdiUyvjwpOMCZ5HvhAlBgF
        3marvQGF1Ec07i+c/XwjtFE/MS49wDBG4hm0t4tBysJBbSO9RnjyLIfW7+NLaaDBEuBLF4Sg8sV
        NFXsJ5RFNuO08h184AxDqRhjH909umgCbuI7pvada+kApPUYYU4eu9L17EqUwgq9t5hmB
X-Received: by 2002:a81:1d07:0:b0:55d:7fd0:e3b9 with SMTP id d7-20020a811d07000000b0055d7fd0e3b9mr384632ywd.1.1683187300284;
        Thu, 04 May 2023 01:01:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5mM+LiDkN7Ul1UmELr2PTiF6LCi7sHr6+8ilAw1VxXAlADmhxeVAnGWqTFb+VDTBR3dJrbK9emCEjC5/SvVAk=
X-Received: by 2002:a81:1d07:0:b0:55d:7fd0:e3b9 with SMTP id
 d7-20020a811d07000000b0055d7fd0e3b9mr384604ywd.1.1683187299974; Thu, 04 May
 2023 01:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <error27/smatch/pull/6@github.com> <5c1e8246-93e0-4480-9514-9e7dcd09f669@kili.mountain>
In-Reply-To: <5c1e8246-93e0-4480-9514-9e7dcd09f669@kili.mountain>
From:   Vladimir Petko <vladimir.petko@canonical.com>
Date:   Thu, 4 May 2023 10:01:29 +0200
Message-ID: <CALFf3kc9AcFYXwhu7+g_t5U4U+pD860kW5Tw8dYJb1AjBGp_8Q@mail.gmail.com>
Subject: Re: [error27/smatch] sparse-llvm: Update function calls to use LLVM
 API changes (PR #6)
To:     linux-sparse@vger.kernel.org
Cc:     Gleb Chesnokov <gleb.chesnokov@scst.dev>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: multipart/mixed; boundary="0000000000001b51cc05fad99547"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

--0000000000001b51cc05fad99547
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Sparse Maintainers,

I am copying the bug report[1] to the mailing list as per the email below.

Building sparse-llvm against LLVM 15 results in test failures due to the
segmentation faults[2].
Would it be possible to consider an attached patch to migrate the
sparse-llvm source code to the opaque pointers [3] at some point?

Best Regards,
 Vladimir.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217153
[2] https://launchpadlibrarian.net/654787464/sparse_0.6.4-3_amd64-2023-03-0=
6T19%3A31%3A07Z.build
[3] https://llvm.org/docs/OpaquePointers.html

On Wed, May 3, 2023 at 2:54=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> Hi Gleb,
>
> I don't maintain Sparse.
>
> I'm afraid you're going to have to send this as a patch to the Sparse
> mailing list.  They don't do git pulls.
>
> linux-sparse@vger.kernel.org
>
> The documentation for how to send code to Sparse seems to be bad
> because I'm seeing now that Vladimir Petko filed a bugzilla to get
> their LLVM code merged...  Let me add him to the CC list.
>
> regards,
> dan carpenter
>
> On Wed, May 03, 2023 at 05:40:12AM -0700, Gleb Chesnokov wrote:
> > This patch updates sparse-llvm to use the newer LLVM API functions, rep=
lacing the deprecated functions with their updated counterparts:
> >
> > - Replace LLVMConstGEP with LLVMConstGEP2
> > - Replace LLVMBuildInBoundsGEP with LLVMBuildInBoundsGEP2
> > - Replace LLVMBuildLoad with LLVMBuildLoad2
> > - Replace LLVMBuildCall with LLVMBuildCall2
> >
> > The patch also ensures that the correct element types are passed to the=
 new functions as required.
> > You can view, comment on, or merge this pull request online at:
> >
> >   https://github.com/error27/smatch/pull/6
> >
> > -- Commit Summary --
> >
> >   * sparse-llvm: Update function calls to use LLVM API changes
> >
> > -- File Changes --
> >
> >     M sparse-llvm.c (16)
> >
> > -- Patch Links --
> >
> > https://github.com/error27/smatch/pull/6.patch
> > https://github.com/error27/smatch/pull/6.diff
> >
> > --
> > Reply to this email directly or view it on GitHub:
> > https://github.com/error27/smatch/pull/6
> > You are receiving this because you are subscribed to this thread.
> >
> > Message ID: &lt;error27/smatch/pull/6@github.com&gt;

--0000000000001b51cc05fad99547
Content-Type: text/x-patch; charset="US-ASCII"; name="llvm-15.diff"
Content-Disposition: attachment; filename="llvm-15.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lh8u73010>
X-Attachment-Id: f_lh8u73010

RGVzY3JpcHRpb246IEZpeCBMTFZNIDE1IGRlcHJlY2F0aW9uIHdhcm5pbmdzCiBMTFZNIDE1IHN3
aXRjaGVkIHRvIG9wYXF1ZSBwb2ludGVycyBieSBkZWZhdWx0IGFuZCBubyBsb25nZXIgc3VwcG9y
dHMgdHlwZWQgcG9pbnRlcnMuCiBSZW1vdmUgZGVwcmVjYXRlZCBMTFZNIGNhbGxzLCB1cGRhdGUg
dGVzdCB0byByZW1vdmUgdHlwZWQgcG9pbnRlcnMuCkF1dGhvcjogVmxhZGltaXIgUGV0a28gPHZs
YWRpbWlyLnBldGtvQGNhbm9uaWNhbC5jb20+Ckxhc3QtVXBkYXRlOiAyMDIzLTAzLTA3IAotLS0K
VGhpcyBwYXRjaCBoZWFkZXIgZm9sbG93cyBERVAtMzogaHR0cDovL2RlcC5kZWJpYW4ubmV0L2Rl
cHMvZGVwMy8KLS0tIGEvc3BhcnNlLWxsdm0uYworKysgYi9zcGFyc2UtbGx2bS5jCkBAIC0yOTUs
MTQgKzI5NSwxOCBAQAogCQljYXNlIEVYUFJfU1RSSU5HOiB7CiAJCQljb25zdCBjaGFyICpzID0g
ZXhwci0+c3RyaW5nLT5kYXRhOwogCQkJTExWTVZhbHVlUmVmIGluZGljZXNbXSA9IHsgTExWTUNv
bnN0SW50KExMVk1JbnQ2NFR5cGUoKSwgMCwgMCksIExMVk1Db25zdEludChMTFZNSW50NjRUeXBl
KCksIDAsIDApIH07CisJCQlMTFZNVHlwZVJlZiB0eXBlX3JlZiA9IExMVk1BcnJheVR5cGUoTExW
TUludDhUeXBlKCksIHN0cmxlbihzKSArIDEpOwogCQkJTExWTVZhbHVlUmVmIGRhdGE7CiAKLQkJ
CWRhdGEgPSBMTFZNQWRkR2xvYmFsKG1vZHVsZSwgTExWTUFycmF5VHlwZShMTFZNSW50OFR5cGUo
KSwgc3RybGVuKHMpICsgMSksICIuc3RyIik7CisJCQlkYXRhID0gTExWTUFkZEdsb2JhbChtb2R1
bGUsIHR5cGVfcmVmLCAiLnN0ciIpOwogCQkJTExWTVNldExpbmthZ2UoZGF0YSwgTExWTVByaXZh
dGVMaW5rYWdlKTsKIAkJCUxMVk1TZXRHbG9iYWxDb25zdGFudChkYXRhLCAxKTsKIAkJCUxMVk1T
ZXRJbml0aWFsaXplcihkYXRhLCBMTFZNQ29uc3RTdHJpbmcoc3RyZHVwKHMpLCBzdHJsZW4ocykg
KyAxLCB0cnVlKSk7Ci0KKyNpZiBMTFZNX1ZFUlNJT05fTUFKT1IgPiAxNAorCQkJcmVzdWx0ID0g
TExWTUNvbnN0R0VQMih0eXBlX3JlZiwgZGF0YSwgaW5kaWNlcywgQVJSQVlfU0laRShpbmRpY2Vz
KSk7CisjZWxzZQogCQkJcmVzdWx0ID0gTExWTUNvbnN0R0VQKGRhdGEsIGluZGljZXMsIEFSUkFZ
X1NJWkUoaW5kaWNlcykpOworI2VuZGlmCiAJCQlyZXR1cm4gcmVzdWx0OwogCQl9CiAJCWRlZmF1
bHQ6CkBAIC00MDcsNiArNDExLDE0IEBACiAJY2hhciBuYW1lW01BWF9QU0VVRE9fTkFNRV07CiAK
IAlwc2V1ZG9fbmFtZShwc2V1ZG8sIG5hbWUpOworI2lmIExMVk1fVkVSU0lPTl9NQUpPUiA+IDE0
CisJaWYgKExMVk1HZXRUeXBlS2luZChMTFZNVHlwZU9mKHZhbCkpID09IExMVk1Qb2ludGVyVHlw
ZUtpbmQKKwkJJiYgTExWTUdldFR5cGVLaW5kKGR0eXBlKSA9PSBMTFZNSW50ZWdlclR5cGVLaW5k
KSB7CisJCWR0eXBlID0gTExWTUludFR5cGUoYml0c19pbl9wb2ludGVyKTsKKwkJcmV0dXJuIExM
Vk1CdWlsZFB0clRvSW50KGZuLT5idWlsZGVyLCB2YWwsIGR0eXBlLCBuYW1lKTsKKwl9CisJZWxz
ZQorI2VuZGlmCiAJcmV0dXJuIExMVk1CdWlsZEJpdENhc3QoZm4tPmJ1aWxkZXIsIHZhbCwgZHR5
cGUsIG5hbWUpOwogfQogCkBAIC00ODUsNyArNDk3LDExIEBACiAJLyogY29udmVydCBiYXNlIHRv
IGNoYXIqIHR5cGUgKi8KIAliYXNlID0gTExWTUJ1aWxkUG9pbnRlckNhc3QoYnVpbGRlciwgYmFz
ZSwgYnl0ZXAsIG5hbWUpOwogCS8qIGFkZHIgPSBiYXNlICsgb2ZmICovCisjaWYgTExWTV9WRVJT
SU9OX01BSk9SID4gMTQKKwlhZGRyID0gTExWTUJ1aWxkSW5Cb3VuZHNHRVAyKGJ1aWxkZXIsIExM
Vk1UeXBlT2YoYmFzZSksICBiYXNlLCAmb2ZmLCAxLCBuYW1lKTsKKyNlbHNlCiAJYWRkciA9IExM
Vk1CdWlsZEluQm91bmRzR0VQKGJ1aWxkZXIsIGJhc2UsICZvZmYsIDEsIG5hbWUpOworI2VuZGlm
CiAJLyogY29udmVydCBiYWNrIHRvIHRoZSBhY3R1YWwgcG9pbnRlciB0eXBlICovCiAJYWRkciA9
IExMVk1CdWlsZFBvaW50ZXJDYXN0KGJ1aWxkZXIsIGFkZHIsIHR5cGUsIG5hbWUpOwogCXJldHVy
biBhZGRyOwpAQCAtNTkzLDcgKzYwOSw3IEBACiAJY2FzZSBPUF9GRElWOgogCQl0YXJnZXQgPSBM
TFZNQnVpbGRGRGl2KGZuLT5idWlsZGVyLCBsaHMsIHJocywgdGFyZ2V0X25hbWUpOwogCQlicmVh
azsKLQkKKwogCS8qIExvZ2ljYWwgKi8KIAljYXNlIE9QX0FORDoKIAkJYXNzZXJ0KCFpc19mbG9h
dF90eXBlKGluc24tPnR5cGUpKTsKQEAgLTcxMSw3ICs3MjcsMTEgQEAKIAogCS8qIHBlcmZvcm0g
bG9hZCAqLwogCXBzZXVkb19uYW1lKGluc24tPnRhcmdldCwgbmFtZSk7CisjaWYgTExWTV9WRVJT
SU9OX01BSk9SID4gMTQKKwl0YXJnZXQgPSBMTFZNQnVpbGRMb2FkMihmbi0+YnVpbGRlciwgTExW
TVR5cGVPZihhZGRyKSwgYWRkciwgbmFtZSk7CisjZWxzZQogCXRhcmdldCA9IExMVk1CdWlsZExv
YWQoZm4tPmJ1aWxkZXIsIGFkZHIsIG5hbWUpOworI2VuZGlmCiAKIAlpbnNuLT50YXJnZXQtPnBy
aXYgPSB0YXJnZXQ7CiB9CkBAIC03OTQsNiArODE0LDI5IEBACiAJfSBFTkRfRk9SX0VBQ0hfUFRS
KGptcCk7CiB9CiAKKyNpZiBMTFZNX1ZFUlNJT05fTUFKT1IgPiAxNAorc3RhdGljIExMVk1UeXBl
UmVmIG1ha2VfZnVuY3Rpb25fdHlwZShzdHJ1Y3Qgc3ltYm9sICpyZXQsIExMVk1WYWx1ZVJlZiAq
YXJncywgaW50IG5fYXJnKQoreworCWludCBpOworCUxMVk1UeXBlUmVmIHJldF90eXBlID0gc3lt
Ym9sX3R5cGUocmV0KTsKKwlMTFZNVHlwZVJlZiAqdHlwZXMgPSBjYWxsb2Mobl9hcmcsIHNpemVv
ZihMTFZNVHlwZVJlZikpOworCWZvciAoaSA9IDA7IGkgPCBuX2FyZzsrK2kpCisJCXR5cGVzW2ld
ID0gTExWTVR5cGVPZihhcmdzW2ldKTsKKwlyZXR1cm4gTExWTUZ1bmN0aW9uVHlwZShyZXRfdHlw
ZSwgdHlwZXMsIG5fYXJnLCAwKTsKK30KKworc3RhdGljIExMVk1WYWx1ZVJlZiBidWlsZF9jYWxs
KGNoYXIgKm5hbWUsIExMVk1WYWx1ZVJlZiBmdW5jLAorCXN0cnVjdCBmdW5jdGlvbiAqZm4sIHN0
cnVjdCBpbnN0cnVjdGlvbiAqaW5zbiwgTExWTVZhbHVlUmVmICphcmdzLCBpbnQgbl9hcmcpCit7
CisJTExWTVR5cGVSZWYgZnVuY3Rpb25fdHlwZTsKKwlpZiAoaW5zbi0+ZnVuYy0+dHlwZSA9PSBQ
U0VVRE9fU1lNKQorCQlmdW5jdGlvbl90eXBlID0gc3ltYm9sX3R5cGUoaW5zbi0+ZnVuYy0+c3lt
KTsKKwllbHNlCisJCWZ1bmN0aW9uX3R5cGUgPSBtYWtlX2Z1bmN0aW9uX3R5cGUoaW5zbi0+dHlw
ZSwgYXJncywgbl9hcmcpOworCXJldHVybiBMTFZNQnVpbGRDYWxsMihmbi0+YnVpbGRlciwgZnVu
Y3Rpb25fdHlwZSwgZnVuYywgYXJncywgbl9hcmcsIG5hbWUpOworfQorI2VuZGlmCisKIHN0YXRp
YyB2b2lkIG91dHB1dF9vcF9jYWxsKHN0cnVjdCBmdW5jdGlvbiAqZm4sIHN0cnVjdCBpbnN0cnVj
dGlvbiAqaW5zbikKIHsKIAlMTFZNVmFsdWVSZWYgdGFyZ2V0LCBmdW5jOwpAQCAtODE5LDcgKzg2
MiwxMSBAQAogCUZJTklTSF9QVFJfTElTVChjdHlwZSk7CiAKIAlwc2V1ZG9fbmFtZShpbnNuLT50
YXJnZXQsIG5hbWUpOworI2lmIExMVk1fVkVSU0lPTl9NQUpPUiA+IDE0CisJdGFyZ2V0ID0gYnVp
bGRfY2FsbChuYW1lLCBmdW5jLCBmbiwgaW5zbiwgYXJncywgbl9hcmcpOworI2Vsc2UKIAl0YXJn
ZXQgPSBMTFZNQnVpbGRDYWxsKGZuLT5idWlsZGVyLCBmdW5jLCBhcmdzLCBuX2FyZywgbmFtZSk7
CisjZW5kaWYKIAogCWluc24tPnRhcmdldC0+cHJpdiA9IHRhcmdldDsKIH0KLS0tIGEvdmFsaWRh
dGlvbi9iYWNrZW5kL2NhbGwtdmFyaWFkaWMuYworKysgYi92YWxpZGF0aW9uL2JhY2tlbmQvY2Fs
bC12YXJpYWRpYy5jCkBAIC0xMSwxNyArMTEsOSBAQAogLyoKICAqIGNoZWNrLW5hbWU6IGNhbGwt
dmFyaWFkaWMKICAqIGNoZWNrLWNvbW1hbmQ6IHNwYXJzZS1sbHZtLWRpcyAtbTY0ICRmaWxlCisg
KiBjaGVjay1vdXRwdXQtaWdub3JlCisgKiBjaGVjay1vdXRwdXQtY29udGFpbnM6ICwgLi4uKSBA
cHJpbnQocHRyICVBUkcxLiwgaTMyIDEyMCwgaTMyICVBUkcyLiwgaTMyIDgsIGk2NCAlQVJHMy4s
IGk2NCAwLCBwdHIgJUFSRzQuLCBwdHIgbnVsbCkKKyAqIGNoZWNrLW91dHB1dC1jb250YWluczog
ZGVmaW5lIGkzMiBAZm9vKAorICogY2hlY2stb3V0cHV0LWNvbnRhaW5zOiBkZWNsYXJlIGkzMiBA
cHJpbnQoCiAgKgotICogY2hlY2stb3V0cHV0LXN0YXJ0Ci07IE1vZHVsZUlEID0gJzxzdGRpbj4n
Ci1zb3VyY2VfZmlsZW5hbWUgPSAic3BhcnNlIgotCi1kZWZpbmUgaTMyIEBmb28oaTgqICVBUkcx
LiwgaTMyICVBUkcyLiwgaTY0ICVBUkczLiwgaTMyKiAlQVJHNC4pIHsKLUwwOgotICAlUjUuID0g
Y2FsbCBpMzIgKGk4KiwgLi4uKSBAcHJpbnQoaTgqICVBUkcxLiwgaTMyIDEyMCwgaTMyICVBUkcy
LiwgaTMyIDgsIGk2NCAlQVJHMy4sIGk2NCAwLCBpMzIqICVBUkc0LiwgaTgqIG51bGwpCi0gIHJl
dCBpMzIgJVI1LgotfQotCi1kZWNsYXJlIGkzMiBAcHJpbnQoaTgqLCAuLi4pCi0gKiBjaGVjay1v
dXRwdXQtZW5kCiAgKi8K
--0000000000001b51cc05fad99547--
