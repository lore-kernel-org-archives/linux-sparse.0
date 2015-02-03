From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] Avoid reuse of string buffer when concatening adjacent string litterals
Date: Tue, 03 Feb 2015 23:38:02 +0100
Message-ID: <87386mvcxh.fsf@rasmusvillemoes.dk>
References: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
	<20150131012339.GA3460@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:59746 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbbBCWiH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 3 Feb 2015 17:38:07 -0500
Received: by mail-la0-f51.google.com with SMTP id ge10so55162298lab.10
        for <linux-sparse@vger.kernel.org>; Tue, 03 Feb 2015 14:38:04 -0800 (PST)
In-Reply-To: <20150131012339.GA3460@macpro.local> (Luc Van Oostenryck's
	message of "Sat, 31 Jan 2015 02:23:40 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

On Sat, Jan 31 2015, Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:

> In get_string_constant(), the code tried to reuse the storage for the string
> but only if the expansion of the string was not bigger than its unexpanded form.
> But this fail when the string constant is a sequence of adjacent string litterals
> (each being possibly shared, used elsewhere, isolated or in another order).
> The minimal exemple would be something like this:
>
> #define P "\001"
> const char a[] = P "a";
> const char b[] = P "b";
>
> The expansion for 'a' will produce a string which is smaller than
> the unexpanded "\001" (2 instead of 4).
> By trying to reuse the storage, all further occurrence of "\001"
> (probably only from the same 'origin', here the macro P) will then be replaced by "\001a".
>
> The fix is thus to not try to reuse the storage for the string if it consit of
> several adjacent litterals.
>

Thanks, but there's still something wrong. Using your show-data feature
on this:

===
#define BACKSLASH "\\"
#define LETTER_t "t"

static const char s1[] = BACKSLASH;
/* static const char s2[] = BACKSLASH; */
static const char s3[] = BACKSLASH LETTER_t;
static const char s4[] = "a" BACKSLASH LETTER_t "b";
===

I get

symbol s1:
        char static const [toplevel] s1[0]
        bit_size = 16
        val = "\\"
symbol s3:
        char static const [toplevel] s3[0]
        bit_size = 24
        val = "\0t"
symbol s4:
        char static const [toplevel] s4[0]
        bit_size = 40
        val = "a\0tb"

Now if I do the same with s2 not commented out, I get


symbol s1:
        char static const [toplevel] s1[0]
        bit_size = 16
        val = "\0"
symbol s2:
        char static const [toplevel] s2[0]
        bit_size = 16
        val = "\0"
symbol s3:
        char static const [toplevel] s3[0]
        bit_size = 24
        val = "\0t"
symbol s4:
        char static const [toplevel] s4[0]
        bit_size = 40
        val = "a\0tb"

So the expansion of BACKSLASH changes depending on how often it is
expanded...

The LETTER_t thing above is because I thought I had somehow provoked a
double expansion, making BACKSLASH LETTER_t (or some variant) expand to
a single-character string containing just a tab. But I can't seem to
reproduce that particular behaviour, so maybe I'm imagining
stuff. Anyway, the above is certainly real.

Thanks,
Rasmus
