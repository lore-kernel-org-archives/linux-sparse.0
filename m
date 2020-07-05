From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 14/15] cleanup: move parsing helpers to parse.c
Date: Sun, 5 Jul 2020 10:27:36 -0700
Message-ID: <CAHk-=wh-Eb-LZawa7fH7BOmbq-t8t8GvaY7o9bEW9cGXZgKGsQ@mail.gmail.com>
References: <20200705130220.26230-1-luc.vanoostenryck@gmail.com> <20200705130220.26230-15-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgGER15 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 13:27:57 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A027CC061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 10:27:56 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y13so21263639lfe.9
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 10:27:56 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id w4sm7338809ljw.16.2020.07.05.10.27.52
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2020 10:27:52 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id h22so35427466lji.9
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 10:27:52 -0700 (PDT)
In-Reply-To: <20200705130220.26230-15-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sun, Jul 5, 2020 at 6:02 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> lib.c contains 2-3 helpers for parsing. Move them to parse.c.

This makes sense, because it's not a "library" function if it's only
used in one place.

HOWEVER.

When doing things like this, please also mark the resulting function
static and remove the declaration from lib.h.

Otherwise it's entirely pointless, I feel.

Either it's a library function that gets used from other places (and
lib.c/lib.h is an appropriate place), or it's a parsing-only helper
function that _doesn't_ get used from other places (and it should be
moved to parse.c and be static).

Not this half-way state that this patch seems to create.

               Linus
