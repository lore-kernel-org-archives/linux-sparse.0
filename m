Return-Path: <SRS0=GL7X=A5=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7335C433E0
	for <linux-sparse@archiver.kernel.org>; Sat, 18 Jul 2020 20:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 974532073E
	for <linux-sparse@archiver.kernel.org>; Sat, 18 Jul 2020 20:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595103716;
	bh=X27o3Nc/8vo+qL/o2FQkdDT+XU9Ki49koK277iIBJH8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PZlSH4ifpPuKK11sdvBACUT4XN/4MoD2Uzihz4hJixTqodZ5alw+jCpjqmLnQjVwG
	 vXqjOSTnvj3stiGHznrE5W9wcTiCEoNXubVQQrZnuNpfpB8SymjxGt74U71k1rQY+W
	 c67qhDYmpoS2NpEoUBrwmwcynVj8qc8wsEvzbxp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgGRUV4 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 18 Jul 2020 16:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgGRUV4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Jul 2020 16:21:56 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E241C0619D2
        for <linux-sparse@vger.kernel.org>; Sat, 18 Jul 2020 13:21:55 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id k15so7835440lfc.4
        for <linux-sparse@vger.kernel.org>; Sat, 18 Jul 2020 13:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SAQx9Ea8B2i8kFBfH0ah5skSx0ayYlLZ4qvEmgFcGq8=;
        b=d3UAu6tEHQb+Ze6w6U3NS8GWno0etR5Iu09V2ML53g+t1O9/cA1Xs9bnqFzc4URg8e
         axtqzS6KlMuHkbYPzn11q60PvYKuqGDRF92BIAM9iA8mC/S6ZfvtvuykWusPMyVNWxju
         BXjA0p+6gU4P6/vx9CCq3/f32fdtTsxDx2NL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SAQx9Ea8B2i8kFBfH0ah5skSx0ayYlLZ4qvEmgFcGq8=;
        b=Er2ewh0xZan+wQ0QTAGfkP0cHPk/JQhI51gvy7rlV/LkGUWrNSnZ1wPpVGaM4oJWzP
         krjKl+ufM89JdlQ4k1mQXinMDPKLx58Zmi3Yr9bxDAlfp3YpcJXp6zfAygJtPOfQKh5s
         aP6LJMgLl22dCbirqyClMd0Q+F02ueu9jD+OeXGLbwPNsed87lJmOjjTOvF6UkXHvDBG
         5xVc+Z+NaRdeBMyHMGphjV9TCe3Gkg9qEQNzM+SVU76Edv/N/yCN9kjd6kSrLFsY3eJs
         9kjTInsi7JcXLotvt+bS/7vRWkKIcDD77JI4yIYP1Grb18rxDMW0PWEQV80auL9j4gXI
         Y51Q==
X-Gm-Message-State: AOAM5322zuqRa0iDkJWp6PAiCkwRzN64DJtJXM0zMrsodCarwEtmpsqs
        j/UITm1bXho0nuaoGQF+tSPAxoelI7k=
X-Google-Smtp-Source: ABdhPJylErtfcMyA36F3ihx+BMW31T4xDFVS/BSZS9NOp/qF6ggr8B7CQpXL2kmFhjx4OsUzZ9kV4Q==
X-Received: by 2002:a19:814c:: with SMTP id c73mr6491370lfd.16.1595103712981;
        Sat, 18 Jul 2020 13:21:52 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id k20sm2335671ljc.111.2020.07.18.13.21.51
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2020 13:21:51 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id k17so7831746lfg.3
        for <linux-sparse@vger.kernel.org>; Sat, 18 Jul 2020 13:21:51 -0700 (PDT)
X-Received: by 2002:a19:8a07:: with SMTP id m7mr7294273lfd.31.1595103711074;
 Sat, 18 Jul 2020 13:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200718183955.16718-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20200718183955.16718-1-luc.vanoostenryck@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Jul 2020 13:21:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjAe_XCz9O2z_FRAOw4iA1+zF9Mcvi3Mp17tpH9y+cLkQ@mail.gmail.com>
Message-ID: <CAHk-=wjAe_XCz9O2z_FRAOw4iA1+zF9Mcvi3Mp17tpH9y+cLkQ@mail.gmail.com>
Subject: Re: [PATCH] warnings: ensure the source filename is shown at least once
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000014402305aabd0649"
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

--00000000000014402305aabd0649
Content-Type: text/plain; charset="UTF-8"

On Sat, Jul 18, 2020 at 11:40 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> When checking a series of files, if some warnings or errors
> are issued but only coming from some includes, it's not possible
> to identify which source file is responsible since its filename
> is not displayed.
>
> So, if the first warning is from a file other than the source
> file, display first a note coming from the source file itself.

This really isn't enough when the include chain is deeper and more complex.

How about something a bit more complex? This is only lightly tested,
but I don't have time for anything more right now..

It results in things like

    kernel/exit.c: note: in included file (through
include/linux/sched/signal.h, include/linux/rcuwait.h,
include/linux/percpu-rwsem.h, include/linux/fs.h,
include/linux/huge_mm.h, include/linux/mm.h):
    ./include/linux/sched/task.h:115:34: warning: context imbalance in
'wait_task_zombie' - unexpected unlock
    ./include/linux/sched/task.h:115:34: warning: context imbalance in
'wait_task_stopped' - unexpected unlock
    ./include/linux/sched/task.h:115:34: warning: context imbalance in
'wait_task_continued' - unexpected unlock

to give an example of a warning happening in a header file that got
included through a deeper chain.

That stream chaining information might perhaps be useful for other cases too?

Would it be better to save the whole 'pos' for the chain, so that
you'd get line numbers etc for the chain? Probably. As mentioned, this
is a quick "how about something like this".

If you extend it and do more testing, you can have my sign-off, or
just take ownership of the patch entirely with my ack..

Now off for more kernel stuff after a quick sparse excursion...

                   Linus

--00000000000014402305aabd0649
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kcs3e4a20>
X-Attachment-Id: f_kcs3e4a20

IGxpYi5jICAgICAgICAgfCA4NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLQogcHJlLXByb2Nlc3MuYyB8IDEyICsrKystLS0tLQogc3lt
Ym9sLmMgICAgICB8ICAyICstCiB0b2tlbi5oICAgICAgIHwgIDcgKystLS0KIHRva2VuaXplLmMg
ICAgfCAxNCArKysrKysrLS0tCiA1IGZpbGVzIGNoYW5nZWQsIDEwMyBpbnNlcnRpb25zKCspLCAx
OCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9saWIuYyBiL2xpYi5jCmluZGV4IDRlOGQ3YjQ1
Li5kY2JiYjViMyAxMDA2NDQKLS0tIGEvbGliLmMKKysrIGIvbGliLmMKQEAgLTQ5LDIyICs0OSw5
OCBAQAogI2luY2x1ZGUgInZlcnNpb24uaCIKICNpbmNsdWRlICJiaXRzLmgiCiAKK3N0YXRpYyBp
bnQgcHJldHRpZnkoY29uc3QgY2hhciAqKmZuYW1lcCkKK3sKKwljb25zdCBjaGFyICpuYW1lID0g
KmZuYW1lcDsKKwlpbnQgbGVuID0gc3RybGVuKG5hbWUpOworCisJaWYgKGxlbiA+IDIgJiYgIW1l
bWNtcChuYW1lLCAiLi8iLCAyKSkgeworCQluYW1lICs9IDI7CisJCWxlbiAtPSAyOworCX0KKwor
CSpmbmFtZXAgPSBuYW1lOworCXJldHVybiBsZW47Cit9CisKK3N0YXRpYyBjb25zdCBjaGFyICpz
aG93X2luY2x1ZGVfY2hhaW4oaW50IHN0cmVhbSwgY29uc3QgY2hhciAqYmFzZSkKK3sKKwlzdGF0
aWMgY2hhciBidWZmZXJbMjAwXTsKKwlpbnQgbGVuID0gMDsKKworCXdoaWxlICgoc3RyZWFtID0g
c3RyZWFtX3ByZXYoc3RyZWFtKSkgPj0gMCkgeworCQljb25zdCBjaGFyICpwID0gc3RyZWFtX25h
bWUoc3RyZWFtKTsKKwkJaW50IHByZXR0eV9sZW47CisKKwkJaWYgKHAgPT0gYmFzZSkKKwkJCWJy
ZWFrOworCisJCXByZXR0eV9sZW4gPSBwcmV0dGlmeSgmcCk7CisJCWlmIChwcmV0dHlfbGVuIDw9
IDApCisJCQlicmVhazsKKworCQkvKgorCQkgKiBBdCB3b3JzdCwgd2UnbGwgbmVlZCAiICh0aHJv
dWdoICVzLCAuLi4pIiBpbiBhZGRpdGlvbiB0byB0aGUKKwkJICogbmV3IGZpbGVuYW1lCisJCSAq
LworCQlpZiAocHJldHR5X2xlbiArIGxlbiArIDIwID4gc2l6ZW9mKGJ1ZmZlcikpIHsKKwkJCWlm
ICghbGVuKQorCQkJCXJldHVybiAiIjsKKwkJCW1lbWNweShidWZmZXIrbGVuLCAiLCAuLi4iLCA1
KTsKKwkJCWxlbiArPSA1OworCQkJYnJlYWs7CisJCX0KKworCQlpZiAoIWxlbikgeworCQkJbWVt
Y3B5KGJ1ZmZlciwgIiAodGhyb3VnaCAiLCAxMCk7CisJCQlsZW4gPSAxMDsKKwkJfSBlbHNlIHsK
KwkJCWJ1ZmZlcltsZW4rK10gPSAnLCc7CisJCQlidWZmZXJbbGVuKytdID0gJyAnOworCQl9CisK
KwkJbWVtY3B5KGJ1ZmZlcitsZW4sIHAsIHByZXR0eV9sZW4pOworCQlsZW4gKz0gcHJldHR5X2xl
bjsKKwl9CisJaWYgKCFsZW4pCisJCXJldHVybiAiIjsKKworCWJ1ZmZlcltsZW5dID0gJyknOwor
CWJ1ZmZlcltsZW4rMV0gPSAwOworCXJldHVybiBidWZmZXI7Cit9CisKK3N0YXRpYyBjb25zdCBj
aGFyICpzaG93X3N0cmVhbV9uYW1lKHN0cnVjdCBwb3NpdGlvbiBwb3MpCit7CisJY29uc3QgY2hh
ciAqbmFtZSA9IHN0cmVhbV9uYW1lKHBvcy5zdHJlYW0pOworCXN0YXRpYyBjb25zdCBjaGFyICps
YXN0OworCisJaWYgKG5hbWUgPT0gYmFzZV9maWxlbmFtZSkKKwkJcmV0dXJuIG5hbWU7CisJaWYg
KG5hbWUgPT0gbGFzdCkKKwkJcmV0dXJuIG5hbWU7CisJbGFzdCA9IG5hbWU7CisKKwlmcHJpbnRm
KHN0ZGVyciwgIiVzOiBub3RlOiBpbiBpbmNsdWRlZCBmaWxlJXM6XG4iLAorCQliYXNlX2ZpbGVu
YW1lLAorCQlzaG93X2luY2x1ZGVfY2hhaW4ocG9zLnN0cmVhbSwgYmFzZV9maWxlbmFtZSkpOwor
CXJldHVybiBuYW1lOworfQogCiBzdGF0aWMgdm9pZCBkb193YXJuKGNvbnN0IGNoYXIgKnR5cGUs
IHN0cnVjdCBwb3NpdGlvbiBwb3MsIGNvbnN0IGNoYXIgKiBmbXQsIHZhX2xpc3QgYXJncykKIHsK
IAlzdGF0aWMgY2hhciBidWZmZXJbNTEyXTsKLQljb25zdCBjaGFyICpuYW1lOwogCiAJLyogU2h1
dCB1cCB3YXJuaW5ncyBpZiBwb3NpdGlvbiBpcyBiYWRfdG9rZW4ucG9zICovCiAJaWYgKHBvcy50
eXBlID09IFRPS0VOX0JBRCkKIAkJcmV0dXJuOwogCiAJdnNwcmludGYoYnVmZmVyLCBmbXQsIGFy
Z3MpOwkKLQluYW1lID0gc3RyZWFtX25hbWUocG9zLnN0cmVhbSk7Ci0JCQorCiAJZmZsdXNoKHN0
ZG91dCk7CiAJZnByaW50ZihzdGRlcnIsICIlczolZDolZDogJXMlcyVzXG4iLAotCQluYW1lLCBw
b3MubGluZSwgcG9zLnBvcywgZGlhZ19wcmVmaXgsIHR5cGUsIGJ1ZmZlcik7CisJCXNob3dfc3Ry
ZWFtX25hbWUocG9zKSwgcG9zLmxpbmUsIHBvcy5wb3MsCisJCWRpYWdfcHJlZml4LCB0eXBlLCBi
dWZmZXIpOwogfQogCiBzdGF0aWMgaW50IHNob3dfaW5mbyA9IDE7CkBAIC0yNzUsNyArMzUxLDcg
QEAgc3RhdGljIHN0cnVjdCBzeW1ib2xfbGlzdCAqc3BhcnNlX2ZpbGUoY29uc3QgY2hhciAqZmls
ZW5hbWUpCiAJYmFzZV9maWxlbmFtZSA9IGZpbGVuYW1lOwogCiAJLy8gVG9rZW5pemUgdGhlIGlu
cHV0IHN0cmVhbQotCXRva2VuID0gdG9rZW5pemUoZmlsZW5hbWUsIGZkLCBOVUxMLCBpbmNsdWRl
cGF0aCk7CisJdG9rZW4gPSB0b2tlbml6ZShmaWxlbmFtZSwgZmQsIC0xLCBOVUxMLCBpbmNsdWRl
cGF0aCk7CiAJY2xvc2UoZmQpOwogCiAJcmV0dXJuIHNwYXJzZV90b2tlbnN0cmVhbSh0b2tlbik7
CmRpZmYgLS1naXQgYS9wcmUtcHJvY2Vzcy5jIGIvcHJlLXByb2Nlc3MuYwppbmRleCA0MDNlMzUw
Ny4uYWI5NzRiMjIgMTAwNjQ0Ci0tLSBhL3ByZS1wcm9jZXNzLmMKKysrIGIvcHJlLXByb2Nlc3Mu
YwpAQCAtODk0LDcgKzg5NCw3IEBAIHN0YXRpYyB2b2lkIHNldF9zdHJlYW1faW5jbHVkZV9wYXRo
KHN0cnVjdCBzdHJlYW0gKnN0cmVhbSkKICNkZWZpbmUgUEFUSF9NQVggNDA5NgkvLyBmb3IgSHVy
ZCB3aGVyZSBpdCdzIG5vdCBkZWZpbmVkCiAjZW5kaWYKIAotc3RhdGljIGludCB0cnlfaW5jbHVk
ZShjb25zdCBjaGFyICpwYXRoLCBjb25zdCBjaGFyICpmaWxlbmFtZSwgaW50IGZsZW4sIHN0cnVj
dCB0b2tlbiAqKndoZXJlLCBjb25zdCBjaGFyICoqbmV4dF9wYXRoKQorc3RhdGljIGludCB0cnlf
aW5jbHVkZShzdHJ1Y3QgcG9zaXRpb24gcG9zLCBjb25zdCBjaGFyICpwYXRoLCBjb25zdCBjaGFy
ICpmaWxlbmFtZSwgaW50IGZsZW4sIHN0cnVjdCB0b2tlbiAqKndoZXJlLCBjb25zdCBjaGFyICoq
bmV4dF9wYXRoKQogewogCWludCBmZDsKIAlpbnQgcGxlbiA9IHN0cmxlbihwYXRoKTsKQEAgLTkx
MCw4ICs5MTAsOCBAQCBzdGF0aWMgaW50IHRyeV9pbmNsdWRlKGNvbnN0IGNoYXIgKnBhdGgsIGNv
bnN0IGNoYXIgKmZpbGVuYW1lLCBpbnQgZmxlbiwgc3RydWN0CiAJCXJldHVybiAxOwogCWZkID0g
b3BlbihmdWxsbmFtZSwgT19SRE9OTFkpOwogCWlmIChmZCA+PSAwKSB7Ci0JCWNoYXIgKnN0cmVh
bW5hbWUgPSB4bWVtZHVwKGZ1bGxuYW1lLCBwbGVuICsgZmxlbik7Ci0JCSp3aGVyZSA9IHRva2Vu
aXplKHN0cmVhbW5hbWUsIGZkLCAqd2hlcmUsIG5leHRfcGF0aCk7CisJCWNoYXIgKnN0cmVhbW5h
bWUgPSBzdHJlYW1uYW1lID0geG1lbWR1cChmdWxsbmFtZSwgcGxlbiArIGZsZW4pOworCQkqd2hl
cmUgPSB0b2tlbml6ZShzdHJlYW1uYW1lLCBmZCwgcG9zLnN0cmVhbSwgKndoZXJlLCBuZXh0X3Bh
dGgpOwogCQljbG9zZShmZCk7CiAJCXJldHVybiAxOwogCX0KQEAgLTkyMyw3ICs5MjMsNyBAQCBz
dGF0aWMgaW50IGRvX2luY2x1ZGVfcGF0aChjb25zdCBjaGFyICoqcHB0ciwgc3RydWN0IHRva2Vu
ICoqbGlzdCwgc3RydWN0IHRva2VuCiAJY29uc3QgY2hhciAqcGF0aDsKIAogCXdoaWxlICgocGF0
aCA9ICpwcHRyKyspICE9IE5VTEwpIHsKLQkJaWYgKCF0cnlfaW5jbHVkZShwYXRoLCBmaWxlbmFt
ZSwgZmxlbiwgbGlzdCwgcHB0cikpCisJCWlmICghdHJ5X2luY2x1ZGUodG9rZW4tPnBvcywgcGF0
aCwgZmlsZW5hbWUsIGZsZW4sIGxpc3QsIHBwdHIpKQogCQkJY29udGludWU7CiAJCXJldHVybiAx
OwogCX0KQEAgLTk2Niw3ICs5NjYsNyBAQCBzdGF0aWMgaW50IGhhbmRsZV9pbmNsdWRlX3BhdGgo
c3RydWN0IHN0cmVhbSAqc3RyZWFtLCBzdHJ1Y3QgdG9rZW4gKipsaXN0LCBzdHJ1YwogCiAJLyog
QWJzb2x1dGUgcGF0aD8gKi8KIAlpZiAoZmlsZW5hbWVbMF0gPT0gJy8nKSB7Ci0JCWlmICh0cnlf
aW5jbHVkZSgiIiwgZmlsZW5hbWUsIGZsZW4sIGxpc3QsIGluY2x1ZGVwYXRoKSkKKwkJaWYgKHRy
eV9pbmNsdWRlKHRva2VuLT5wb3MsICIiLCBmaWxlbmFtZSwgZmxlbiwgbGlzdCwgaW5jbHVkZXBh
dGgpKQogCQkJcmV0dXJuIDA7CiAJCWdvdG8gb3V0OwogCX0KQEAgLTIwOTEsNyArMjA5MSw3IEBA
IHN0YXRpYyB2b2lkIGNyZWF0ZV9hcmdsaXN0KHN0cnVjdCBzeW1ib2wgKnN5bSwgaW50IGNvdW50
KQogc3RhdGljIHZvaWQgaW5pdF9wcmVwcm9jZXNzb3Iodm9pZCkKIHsKIAlpbnQgaTsKLQlpbnQg
c3RyZWFtID0gaW5pdF9zdHJlYW0oInByZXByb2Nlc3NvciIsIC0xLCBpbmNsdWRlcGF0aCk7CisJ
aW50IHN0cmVhbSA9IGluaXRfc3RyZWFtKCJwcmVwcm9jZXNzb3IiLCAtMSwgaW5jbHVkZXBhdGgs
IC0xKTsKIAlzdGF0aWMgc3RydWN0IHsKIAkJY29uc3QgY2hhciAqbmFtZTsKIAkJaW50ICgqaGFu
ZGxlcikoc3RydWN0IHN0cmVhbSAqLCBzdHJ1Y3QgdG9rZW4gKiosIHN0cnVjdCB0b2tlbiAqKTsK
ZGlmZiAtLWdpdCBhL3N5bWJvbC5jIGIvc3ltYm9sLmMKaW5kZXggYzBjYTc5ZTQuLjJjYzlmODJk
IDEwMDY0NAotLS0gYS9zeW1ib2wuYworKysgYi9zeW1ib2wuYwpAQCAtNzc2LDcgKzc3Niw3IEBA
IHN0cnVjdCBzeW1ib2wJemVyb19pbnQ7CiAKIHZvaWQgaW5pdF9zeW1ib2xzKHZvaWQpCiB7Ci0J
aW50IHN0cmVhbSA9IGluaXRfc3RyZWFtKCJidWlsdGluIiwgLTEsIGluY2x1ZGVwYXRoKTsKKwlp
bnQgc3RyZWFtID0gaW5pdF9zdHJlYW0oImJ1aWx0aW4iLCAtMSwgaW5jbHVkZXBhdGgsIC0xKTsK
IAogI2RlZmluZSBfX0lERU5UKG4sc3RyLHJlcykgXAogCWhhc2hfaWRlbnQoJm4pCmRpZmYgLS1n
aXQgYS90b2tlbi5oIGIvdG9rZW4uaAppbmRleCBjNWZkZjNkMC4uNmQyYjBiNjUgMTAwNjQ0Ci0t
LSBhL3Rva2VuLmgKKysrIGIvdG9rZW4uaApAQCAtNDksNyArNDksNyBAQCBlbnVtIGNvbnN0YW50
ZmlsZSB7CiBleHRlcm4gY29uc3QgY2hhciAqaW5jbHVkZXBhdGhbXTsKIAogc3RydWN0IHN0cmVh
bSB7Ci0JaW50IGZkOworCWludCBmZCwgcHJldjsKIAljb25zdCBjaGFyICpuYW1lOwogCWNvbnN0
IGNoYXIgKnBhdGg7ICAgIC8vIGlucHV0LWZpbGUgcGF0aCAtIHNlZSBzZXRfc3RyZWFtX2luY2x1
ZGVfcGF0aCgpCiAJY29uc3QgY2hhciAqKm5leHRfcGF0aDsKQEAgLTIxNCw3ICsyMTQsOCBAQCBz
dGF0aWMgaW5saW5lIHN0cnVjdCB0b2tlbiAqY29udGFpbmluZ190b2tlbihzdHJ1Y3QgdG9rZW4g
KipwKQogZXh0ZXJuIHN0cnVjdCB0b2tlbiBlb2ZfdG9rZW5fZW50cnk7CiAjZGVmaW5lIGVvZl90
b2tlbih4KSAoKHgpID09ICZlb2ZfdG9rZW5fZW50cnkpCiAKLWV4dGVybiBpbnQgaW5pdF9zdHJl
YW0oY29uc3QgY2hhciAqLCBpbnQgZmQsIGNvbnN0IGNoYXIgKipuZXh0X3BhdGgpOworZXh0ZXJu
IGludCBpbml0X3N0cmVhbShjb25zdCBjaGFyICosIGludCBmZCwgY29uc3QgY2hhciAqKm5leHRf
cGF0aCwgaW50IHByZXZfc3RyZWFtKTsKK2V4dGVybiBpbnQgc3RyZWFtX3ByZXYoaW50IHN0cmVh
bSk7CiBleHRlcm4gY29uc3QgY2hhciAqc3RyZWFtX25hbWUoaW50IHN0cmVhbSk7CiBleHRlcm4g
c3RydWN0IGlkZW50ICpoYXNoX2lkZW50KHN0cnVjdCBpZGVudCAqKTsKIGV4dGVybiBzdHJ1Y3Qg
aWRlbnQgKmJ1aWx0X2luX2lkZW50KGNvbnN0IGNoYXIgKik7CkBAIC0yMjQsNyArMjI1LDcgQEAg
ZXh0ZXJuIGNvbnN0IGNoYXIgKnNob3dfaWRlbnQoY29uc3Qgc3RydWN0IGlkZW50ICopOwogZXh0
ZXJuIGNvbnN0IGNoYXIgKnNob3dfc3RyaW5nKGNvbnN0IHN0cnVjdCBzdHJpbmcgKnN0cmluZyk7
CiBleHRlcm4gY29uc3QgY2hhciAqc2hvd190b2tlbihjb25zdCBzdHJ1Y3QgdG9rZW4gKik7CiBl
eHRlcm4gY29uc3QgY2hhciAqcXVvdGVfdG9rZW4oY29uc3Qgc3RydWN0IHRva2VuICopOwotZXh0
ZXJuIHN0cnVjdCB0b2tlbiAqIHRva2VuaXplKGNvbnN0IGNoYXIgKiwgaW50LCBzdHJ1Y3QgdG9r
ZW4gKiwgY29uc3QgY2hhciAqKm5leHRfcGF0aCk7CitleHRlcm4gc3RydWN0IHRva2VuICogdG9r
ZW5pemUoY29uc3QgY2hhciAqLCBpbnQsIGludCwgc3RydWN0IHRva2VuICosIGNvbnN0IGNoYXIg
KipuZXh0X3BhdGgpOwogZXh0ZXJuIHN0cnVjdCB0b2tlbiAqIHRva2VuaXplX2J1ZmZlcih2b2lk
ICosIHVuc2lnbmVkIGxvbmcsIHN0cnVjdCB0b2tlbiAqKik7CiAKIGV4dGVybiB2b2lkIHNob3df
aWRlbnRpZmllcl9zdGF0cyh2b2lkKTsKZGlmZiAtLWdpdCBhL3Rva2VuaXplLmMgYi90b2tlbml6
ZS5jCmluZGV4IGQzMzcxZTFlLi5jNWJhNmU2YiAxMDA2NDQKLS0tIGEvdG9rZW5pemUuYworKysg
Yi90b2tlbml6ZS5jCkBAIC02Miw2ICs2MiwxMyBAQCBjb25zdCBjaGFyICpzdHJlYW1fbmFtZShp
bnQgc3RyZWFtKQogCXJldHVybiBpbnB1dF9zdHJlYW1zW3N0cmVhbV0ubmFtZTsKIH0KIAoraW50
IHN0cmVhbV9wcmV2KGludCBzdHJlYW0pCit7CisJaWYgKHN0cmVhbSA8IDAgfHwgc3RyZWFtID4g
aW5wdXRfc3RyZWFtX25yKQorCQlyZXR1cm4gLTE7CisJcmV0dXJuIGlucHV0X3N0cmVhbXNbc3Ry
ZWFtXS5wcmV2OworfQorCiBzdGF0aWMgc3RydWN0IHBvc2l0aW9uIHN0cmVhbV9wb3Moc3RyZWFt
X3QgKnN0cmVhbSkKIHsKIAlzdHJ1Y3QgcG9zaXRpb24gcG9zOwpAQCAtMzAwLDcgKzMwNyw3IEBA
IGludCAqaGFzaF9zdHJlYW0oY29uc3QgY2hhciAqbmFtZSkKIAlyZXR1cm4gaW5wdXRfc3RyZWFt
X2hhc2hlcyArIGhhc2g7CiB9CiAKLWludCBpbml0X3N0cmVhbShjb25zdCBjaGFyICpuYW1lLCBp
bnQgZmQsIGNvbnN0IGNoYXIgKipuZXh0X3BhdGgpCitpbnQgaW5pdF9zdHJlYW0oY29uc3QgY2hh
ciAqbmFtZSwgaW50IGZkLCBjb25zdCBjaGFyICoqbmV4dF9wYXRoLCBpbnQgcHJldl9zdHJlYW0p
CiB7CiAJaW50IHN0cmVhbSA9IGlucHV0X3N0cmVhbV9uciwgKmhhc2g7CiAJc3RydWN0IHN0cmVh
bSAqY3VycmVudDsKQEAgLTMxOSw2ICszMjYsNyBAQCBpbnQgaW5pdF9zdHJlYW0oY29uc3QgY2hh
ciAqbmFtZSwgaW50IGZkLCBjb25zdCBjaGFyICoqbmV4dF9wYXRoKQogCWN1cnJlbnQtPm5leHRf
cGF0aCA9IG5leHRfcGF0aDsKIAljdXJyZW50LT5wYXRoID0gTlVMTDsKIAljdXJyZW50LT5jb25z
dGFudCA9IENPTlNUQU5UX0ZJTEVfTUFZQkU7CisJY3VycmVudC0+cHJldiA9IHByZXZfc3RyZWFt
OwogCWlucHV0X3N0cmVhbV9uciA9IHN0cmVhbSsxOwogCWhhc2ggPSBoYXNoX3N0cmVhbShuYW1l
KTsKIAljdXJyZW50LT5uZXh0X3N0cmVhbSA9ICpoYXNoOwpAQCAtMTAwNiwxNCArMTAxNCwxNCBA
QCBzdHJ1Y3QgdG9rZW4gKiB0b2tlbml6ZV9idWZmZXIodm9pZCAqYnVmZmVyLCB1bnNpZ25lZCBs
b25nIHNpemUsIHN0cnVjdCB0b2tlbiAqKgogCXJldHVybiBiZWdpbjsKIH0KIAotc3RydWN0IHRv
a2VuICogdG9rZW5pemUoY29uc3QgY2hhciAqbmFtZSwgaW50IGZkLCBzdHJ1Y3QgdG9rZW4gKmVu
ZHRva2VuLCBjb25zdCBjaGFyICoqbmV4dF9wYXRoKQorc3RydWN0IHRva2VuICogdG9rZW5pemUo
Y29uc3QgY2hhciAqbmFtZSwgaW50IGZkLCBpbnQgcHJldl9zdHJlYW0sIHN0cnVjdCB0b2tlbiAq
ZW5kdG9rZW4sIGNvbnN0IGNoYXIgKipuZXh0X3BhdGgpCiB7CiAJc3RydWN0IHRva2VuICpiZWdp
biwgKmVuZDsKIAlzdHJlYW1fdCBzdHJlYW07CiAJdW5zaWduZWQgY2hhciBidWZmZXJbQlVGU0la
RV07CiAJaW50IGlkeDsKIAotCWlkeCA9IGluaXRfc3RyZWFtKG5hbWUsIGZkLCBuZXh0X3BhdGgp
OworCWlkeCA9IGluaXRfc3RyZWFtKG5hbWUsIGZkLCBuZXh0X3BhdGgsIHByZXZfc3RyZWFtKTsK
IAlpZiAoaWR4IDwgMCkgewogCQkvLyBpbmZvKGVuZHRva2VuLT5wb3MsICJGaWxlICVzIGlzIGNv
bnN0IiwgbmFtZSk7CiAJCXJldHVybiBlbmR0b2tlbjsK
--00000000000014402305aabd0649--
