Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8300BC43217
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Mar 2022 18:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiCaSTG (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Mar 2022 14:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbiCaSTF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Mar 2022 14:19:05 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203341E533E
        for <linux-sparse@vger.kernel.org>; Thu, 31 Mar 2022 11:17:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m3so583289lfj.11
        for <linux-sparse@vger.kernel.org>; Thu, 31 Mar 2022 11:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gADLe4HDBmNTTRadD9I18Eo59xDMA1VeRyu9AlQVupI=;
        b=crQ0nfYz9r5y0LNjvAz6Kl9GkH8VcN7+M3IRO0/MHMSfuwZ3QQbJPMFmMEChGOGuRi
         lgQsMapR+mH3g1uSCfkahgw35sLDQIFcmdfsSdI3qkJ8Vg8TWDA8dUjlprf7JcAT2Psh
         pjWsZFv1Yzq1yQ6rqecDWGyO9u5lr3MHZuD6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gADLe4HDBmNTTRadD9I18Eo59xDMA1VeRyu9AlQVupI=;
        b=XapKeK21v3SmroTQCvnZNqiAVqpHs4e8MUPN6ZXG1aahESJd5NjIqm48/ysZ+PJpNk
         gPh+eXz/IT8BbSipKlqSh1WJFRMh5zQsi52h3Z0Q/JZo7HxDgglwaqJBNbIRNtVrRsAF
         gvYWQiLI9bMEGElMh7viop+hk9q7wC0w8Knv6zDyOhGKpsGyCOJIBWx5jAW8iE0/6w1e
         OBX5jkV4gtL8L8HfH2HHT9JDvmZAIkRSBVZvRgD3SQ7wfUV2w4s7ClcB+8p6LQ7ErmZ9
         98NmyslWadqQlxJ12pEC4b3fDqE1Y5pMSGe7hW1sVDFtnt6mlbKhaqXnuluyCoYODSqK
         rroQ==
X-Gm-Message-State: AOAM5319HrYbxD0EyuCSRUlJvxo+L5t6jWZPOZpSXJxDnguyv6xe1Nbo
        ol282VU5dUVoqdocLRdknr++GgSgwJnzQ9gR
X-Google-Smtp-Source: ABdhPJw/EOTeZ9AhoosxkJsYFyEKn627N9zgS8EcRsxI2KeCz/emA/0e944wnL5z2nQoISosB+qmOw==
X-Received: by 2002:a05:6512:3f95:b0:448:40cd:dcab with SMTP id x21-20020a0565123f9500b0044840cddcabmr11492860lfa.517.1648750633010;
        Thu, 31 Mar 2022 11:17:13 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id v1-20020a2e7a01000000b0024ac272d727sm2701ljc.79.2022.03.31.11.17.10
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 11:17:10 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id b43so843510ljr.10
        for <linux-sparse@vger.kernel.org>; Thu, 31 Mar 2022 11:17:10 -0700 (PDT)
X-Received: by 2002:a2e:9041:0:b0:24a:ce83:dcb4 with SMTP id
 n1-20020a2e9041000000b0024ace83dcb4mr11242362ljg.291.1648750629685; Thu, 31
 Mar 2022 11:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220126171442.1338740-1-aurelien@aurel32.net>
 <20220331103247.y33wvkxk5vfbqohf@pengutronix.de> <20220331103913.2vlneq6clnheuty6@pengutronix.de>
 <20220331105112.7t3qgtilhortkiq4@pengutronix.de>
In-Reply-To: <20220331105112.7t3qgtilhortkiq4@pengutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Mar 2022 11:16:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjnuMD091mNbY=fRm-qFyhMjbtfiwkAFKyFehyR8bPB5A@mail.gmail.com>
Message-ID: <CAHk-=wjnuMD091mNbY=fRm-qFyhMjbtfiwkAFKyFehyR8bPB5A@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix build with binutils 2.38
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Kito Cheng <kito.cheng@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        ukl@pengutronix.de,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000009b482f05db87ab14"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

--0000000000009b482f05db87ab14
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 31, 2022 at 3:51 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> Cc += linux-sparse, Uwe, Luc Van Oostenryck
>
> tl;dr:
>
> A recent change in the kernel regarding the riscv -march handling breaks
> current sparse.

Gaah. Normally sparse doesn't even look at the -march flag, but for
riscv it does, because it's meaningful for the predefined macros.

Maybe that 'die()' shouldn't be so fatal. And maybe add a few more
extensions (but ignore them) to the parsing.

Something ENTIRELY UNTESTED like the attached.

               Linus

--0000000000009b482f05db87ab14
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l1fbjlbv0>
X-Attachment-Id: f_l1fbjlbv0

IHRhcmdldC1yaXNjdi5jIHwgMTQgKysrKysrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC1yaXNjdi5j
IGIvdGFyZ2V0LXJpc2N2LmMKaW5kZXggNmQ5MTEzYzEuLjIwMWFjMzc1IDEwMDY0NAotLS0gYS90
YXJnZXQtcmlzY3YuYworKysgYi90YXJnZXQtcmlzY3YuYwpAQCAtMyw2ICszLDcgQEAKICNpbmNs
dWRlICJ0YXJnZXQuaCIKICNpbmNsdWRlICJtYWNoaW5lLmgiCiAjaW5jbHVkZSA8c3RyaW5nLmg+
CisjaW5jbHVkZSA8c3RkaW8uaD4KIAogI2RlZmluZSBSSVNDVl8zMkJJVAkoMSA8PCAwKQogI2Rl
ZmluZSBSSVNDVl82NEJJVAkoMSA8PCAxKQpAQCAtNDcsNiArNDgsMTIgQEAgc3RhdGljIHZvaWQg
cGFyc2VfbWFyY2hfcmlzY3YoY29uc3QgY2hhciAqYXJnKQogCQl7ICJuIiwJCTAgfSwKIAkJeyAi
aCIsCQkwIH0sCiAJCXsgInMiLAkJMCB9LAorCQl7ICJpIiwJCTAgfSwKKwkJeyAiZSIsCQkwIH0s
CisJCXsgIl8iLAkJMCB9LAorCQl7ICJDb3VudGVycyIsCTAgfSwKKwkJeyAiWmljc3IiLAkwIH0s
CisJCXsgIlppZmVuY2VpIiwJMCB9LAogCX07CiAJaW50IGk7CiAKQEAgLTYwLDcgKzY3LDEwIEBA
IHN0YXRpYyB2b2lkIHBhcnNlX21hcmNoX3Jpc2N2KGNvbnN0IGNoYXIgKmFyZykKIAkJCWdvdG8g
ZXh0OwogCQl9CiAJfQotCWRpZSgiaW52YWxpZCBhcmd1bWVudCB0byAnLW1hcmNoJzogJyVzJ1xu
IiwgYXJnKTsKKwordW5rbm93bjoKKwlmcHJpbnRmKHN0ZGVyciwgIldBUk5JTkc6IGludmFsaWQg
YXJndW1lbnQgdG8gJy1tYXJjaCc6ICclcydcbiIsIGFyZyk7CisJcmV0dXJuOwogCiBleHQ6CiAJ
Zm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoZXh0ZW5zaW9ucyk7IGkrKykgewpAQCAtNzMsNyAr
ODMsNyBAQCBleHQ6CiAJCX0KIAl9CiAJaWYgKGFyZ1swXSkKLQkJZGllKCJpbnZhbGlkIGFyZ3Vt
ZW50IHRvICctbWFyY2gnOiAnJXMnXG4iLCBhcmcpOworCQlnb3RvIHVua25vd247CiB9CiAKIHN0
YXRpYyB2b2lkIGluaXRfcmlzY3YoY29uc3Qgc3RydWN0IHRhcmdldCAqc2VsZikK
--0000000000009b482f05db87ab14--
