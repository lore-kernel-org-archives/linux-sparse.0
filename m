From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How to fix: asm output is not an lvalue
Date: Sat, 26 Apr 2014 16:44:13 -0700
Message-ID: <CA+55aFx0QAPEDBEyb+fDsb+Asb-q_6tb7K=KMLP4o4DxncxSpg@mail.gmail.com>
References: <20140426215705.GA20867@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:48583 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbaDZXoO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 26 Apr 2014 19:44:14 -0400
Received: by mail-ve0-f175.google.com with SMTP id oz11so6362889veb.6
        for <linux-sparse@vger.kernel.org>; Sat, 26 Apr 2014 16:44:13 -0700 (PDT)
In-Reply-To: <20140426215705.GA20867@ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Apr 26, 2014 at 2:57 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Following code snippet generate these warnings:
> t.c:9:9: warning: asm output is not an lvalue

Yeah. That code snippet is pure and utter garbage.

Gcc has this totally insane extension that makes casts be lvalues.
It's stupid and horrid, and pointless to boot. So apparently gcc
accepts that crap.

But it is very much total crap.

Those casts to (USItype) are all pointless to begin with (since the
values are of that type already!) and they mean that the expression
isn't something you can assign to (lvalue). The fact that gcc accepts
code like that is an embarrassment.

            Linus
