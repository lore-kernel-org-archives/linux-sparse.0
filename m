From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Bug 207959] Don't warn about the universal zero initializer for
 a structure with the 'designated_init' attribute.
Date: Thu, 28 May 2020 15:25:39 -0700
Message-ID: <CAHk-=wiKCXoeynr6am-B-_=XP=mQxtxREjP+q_zzMfe5CaeJeQ@mail.gmail.com>
References: <bug-207959-200559@https.bugzilla.kernel.org/> <bug-207959-200559-nznJfyeqKD@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437062AbgE1WZ7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 May 2020 18:25:59 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A367C08C5C6
        for <linux-sparse@vger.kernel.org>; Thu, 28 May 2020 15:25:59 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q2so119006ljm.10
        for <linux-sparse@vger.kernel.org>; Thu, 28 May 2020 15:25:58 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id a16sm1651844ljh.111.2020.05.28.15.25.56
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 15:25:56 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 82so112151lfh.2
        for <linux-sparse@vger.kernel.org>; Thu, 28 May 2020 15:25:56 -0700 (PDT)
In-Reply-To: <bug-207959-200559-nznJfyeqKD@https.bugzilla.kernel.org/>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, May 28, 2020 at 2:24 PM <bugzilla-daemon@bugzilla.kernel.org> wrote:
>
> Well, that's really the point.
> The problem Sparse also gives the warnings corresponding to clang's -Wnonnull
> and my understanding is that these warnings are desired for the kernel even
> when coming from using '{ 0 }'.

In the kernel, the empty initializer is be the usual way to create a
zero initializer. So yes, { 0 } may exist, but it generally should be
used for initializing something that is known to be an integer. And if
it's a pointer, it should warn, because '0' should never have been a
valid pointer, traditional C or not.

It's not like we use pedantic and portable standard C to begin with.

So yeah, the sparse defaults may be a bit kernel-centric.

             Linus
