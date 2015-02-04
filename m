From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] Avoid reuse of string buffer when concatening adjacent string litterals
Date: Wed, 04 Feb 2015 09:58:38 +0100
Message-ID: <87mw4uaw8x.fsf@rasmusvillemoes.dk>
References: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
	<20150131012339.GA3460@macpro.local>
	<87386mvcxh.fsf@rasmusvillemoes.dk>
	<20150204003208.GA8867@macbook.lan>
	<87r3u6ax5f.fsf@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:44703 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331AbbBDI6l (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 4 Feb 2015 03:58:41 -0500
Received: by mail-lb0-f175.google.com with SMTP id 10so347247lbg.6
        for <linux-sparse@vger.kernel.org>; Wed, 04 Feb 2015 00:58:39 -0800 (PST)
In-Reply-To: <87r3u6ax5f.fsf@rasmusvillemoes.dk> (Rasmus Villemoes's message
	of "Wed, 04 Feb 2015 09:39:08 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

On Wed, Feb 04 2015, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> And I wasn't hallucinating, I was just overcomplicating things:
>
> #define NOT_TAB "\\t"
>
> static const char s1[] = NOT_TAB;
> static const char s2[] = NOT_TAB;
>
> indeed fails.

While we're collecting examples, let me also mention that __FILE__
doesn't work for files with backslash in their name. Sane people of
course don't put backslashes in file names, but they are a rather normal
occurence in path names on a certain operating system.

Rasmus

