Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47491C43334
	for <linux-sparse@archiver.kernel.org>; Mon, 27 Jun 2022 19:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiF0TGA (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 27 Jun 2022 15:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237721AbiF0TFx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Jun 2022 15:05:53 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F2D21B1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 12:05:49 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id fd6so14420069edb.5
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 12:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Nd43NybatWGJTBA2qqSGGzDsqnc6MaJgJYMDH2lkG8=;
        b=WsgI1/uFOWAQM3u4UIsN1/Cpu/nKMIozAnQ44R2kPUr7aMcR5hhjpTZfd2/X5ZheCW
         BCCdZSktwcdexYDJ0IGBlUfoeVT4bg0tgz0p7ZF5R7YBCKokD2exjr0D38IPWL+7QxUK
         L1OhBZHkA96QE1HYe/IR14c6YAEkwehVi5Dgvt6k7ePbb5KB7jgrQDVBur49SouJlbu9
         0Njbgw7nS1AKpU/KAJXgrzd3e7gx5eWQHeoCJwWs5avtzDkF5/99sElnIm9EI3x0Vxgs
         MFAAcvIae36Kl3eNK5zLSB3HwvvU26fyBjXcpE/ZthK1dATRKrwsbdvL2gWB3AtjVOFv
         icXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Nd43NybatWGJTBA2qqSGGzDsqnc6MaJgJYMDH2lkG8=;
        b=LJoYgOnLJJvEy4l1KNaerCBvQ+V+a7/pWhHyjwAgH8tCcv0495BZYrenF6T6QIjyQ3
         uxzLBmgNtelldrMlCeGqFaiXu1tFZSlD+QthOk/H0j6KdZYIspqVTSRiqBlBe+2HqVlB
         plXeWGfcZxfHmOPj3JvEyFISbrQrI66Isyj5Z1tK/BD1s2+iy190X3/lwIGHAX2jjy17
         yNjAS3e3vZiRNsHCrQ/Rm03wW3y5nK/7MPemNoBbsCCDl3S/J2CR/jDgWywz4gW2tq8H
         i3lVd8LS0dbGmPW6EDqBk1AfPAaBwxyPafG2nDGC+Ag1AJ4AOAsjwHxETjBo8E4/C9i+
         3gxg==
X-Gm-Message-State: AJIora+nvr9c9Ayh26TCn/aKOFiWfKwu9Wge5Z4QqjPK5CezJGy8iOka
        t8Hba1ybnWA+sfyEYmRE5i58YK5cF+Q=
X-Google-Smtp-Source: AGRyM1tDRg3hKaPvxgsvk0PgHABsdIngyEPkBJrqgb8gbkE3Yie381x+9blUUn8a1I2RGZppiWNGmg==
X-Received: by 2002:a50:ef12:0:b0:435:81f3:a93a with SMTP id m18-20020a50ef12000000b0043581f3a93amr17662554eds.80.1656356747812;
        Mon, 27 Jun 2022 12:05:47 -0700 (PDT)
Received: from localhost.localdomain (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id p24-20020a170906615800b00709343c0017sm5456776ejl.98.2022.06.27.12.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:05:47 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] allow -1 and compares in bitwise types
Date:   Mon, 27 Jun 2022 21:05:35 +0200
Message-Id: <20220627190540.13358-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <CAHk-=wj8gM8q04v2jS5JGjEdoE2d+B4_nm74xrFjZ77f9YRsbA@mail.gmail.com>
References: <CAHk-=wj8gM8q04v2jS5JGjEdoE2d+B4_nm74xrFjZ77f9YRsbA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Allow using -1 and compare operators with bitwise types

This series is an experiment for allowing constants like
-1 or ~0 with bitwise types, as well as using compares
on them.
the motivation for allowing this is to avoid useless casts
and warnings on using some generic macros on bitwise types.
The case of interest here is:
	#define is_signed_type(T) (((T)(-1)) < (T)1)
for which Sparse reports four warnings when 'T' is a bitwise
type. Two of these warnings can be suppressed by using
'__force' in the casts. But the other two can't be worked
around because explicitly reject using any constants other
than 0 with bitwise type.

The changes in the series allow to use the following testcase
without any warnings:
	#define __bitwise __attribute__((bitwise))
	typedef   signed int __bitwise s;
	typedef unsigned int __bitwise u;

	#define is_signed_type(type)  (((type)-1) <= 0)

	int fs(void) { return ((s)-1) <= 0; }
	int fu(void) { return ((u)-1) <= 0; }

and result in a modest but significant decrease in the number
of warnings issued by sparse (x86 {def,all}config):
   -  2736  2735 cast to restricted type
   +   774   792 cast truncates bits from constant value
   -  3183  3152 incorrect type in assignment (different base types)
   -   162   159 incorrect type in initializer (different base types)
   -   789   661 restricted type degrades to integer
   - 13002 12857 Total

@Linus,
This seems to work correctly and I think it correspond to
what you wished (maybe modulo this 'early constant expansion'
I added) and I think that accepting the -1/all-ones is fine.
OTOH, I don't think we can allow the compares because they
don't make any sense for the 'endian' types. Surely we want
to catch things like:
	typedef unsigned int __bitwise __be32;
	__be32 x, y;
	...
	... (x < y)

@Bart,
Is there a good reason why the macro compares against 1 and
not against 0? Is it just because of -Wtype-limits? If so,
is it possible to use '<= 0' like here above?

The series is available for review and testing at:
  https://git.kernel.org/pub/scm/devel/sparse/sparse.git bitwise-ones

Luc Van Oostenryck (5):
  bitwise: add testcases
  bitwise: accept all ones as non-restricted value
  bitwise: allow compares for bitwise types
  bitwise: do not remove the signedness of bitwise types
  bitwise: early expansion of simple constants

 evaluate.c                       | 52 +++++++++++++++++++++++++++++++-
 parse.c                          |  1 -
 show-parse.c                     |  2 +-
 validation/bitwise-cast.c        | 26 ++++++++++++++++
 validation/bitwise-cmp.c         | 31 +++++++++++++++++++
 validation/bitwise-is-signed.c   | 21 +++++++++++++
 validation/linear/bitwise-cmps.c | 17 +++++++++++
 validation/linear/bitwise-cmpu.c | 17 +++++++++++
 8 files changed, 164 insertions(+), 3 deletions(-)
 create mode 100644 validation/bitwise-cmp.c
 create mode 100644 validation/bitwise-is-signed.c
 create mode 100644 validation/linear/bitwise-cmps.c
 create mode 100644 validation/linear/bitwise-cmpu.c

-- 
2.36.1

