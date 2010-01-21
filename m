From: Dan Carpenter <error27@gmail.com>
Subject: Re: Sparse licensing
Date: Thu, 21 Jan 2010 15:08:05 +0300
Message-ID: <a63d67fe1001210408v34d47494m980e291df690319f@mail.gmail.com>
References: <20090702214349.GA19009@feather> <4A4D3468.1010202@garzik.org>
	 <20090702230836.GI19009@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:55568 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab0AUMIG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 21 Jan 2010 07:08:06 -0500
Received: by pxi12 with SMTP id 12so6519980pxi.33
        for <linux-sparse@vger.kernel.org>; Thu, 21 Jan 2010 04:08:05 -0800 (PST)
In-Reply-To: <20090702230836.GI19009@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-sparse@vger.kernel.org, madcoder@debian.org, lool@dooz.org

On 7/3/09, Josh Triplett <josh@kernel.org> wrote:
> On Thu, Jul 02, 2009 at 06:27:52PM -0400, Jeff Garzik wrote:
>> Can you weigh in on the licensing threads, pretty please?  That is
>> still blocked on you, AFAIK.
>
> Sure.
>
> For my part, I'd *love* to see Sparse relicensed to something more
> palatable.  Ideally, I'd love to see Sparse become GPL-compatible.  I'd
> prefer a stronger copyleft over a weaker one.
>
> I have no problem with relicensing Sparse to any of the following
> licenses, in rough order of preference:
>
> - GPL (v2 or v3, with or without "or any later version")
> - LGPL (v2.1 or v3, with or without "or any later version")
> - Either of the above with some kind of additional exception similar to
>   those used for GCC and related libraries.
> - Any of the above dual-licensed with the OSL, if people care about
>   preserving that for some reason.  Seems unnecessarily complex to do
>   so, though.
>
> I'd prefer not to see Sparse relicensed to something entirely
> non-copyleft like the MIT license, but if the rest of the Sparse
> community wants that for some reason, I won't stand in the way.
>
> If you need any more formal approval from me, please let me know.
>
> Thanks,
> Josh Triplett
> --

I'm not a lawyer or anything.  Does this mean we're done?  Can the
Debian people move sparse out of non-free?  Can I re-license smatch?

I used the following command to find who might have to sign off.

git log 1bcc92138dcdf718dc3e0c694565f56e669d6ee3 master | grep Author
| cut -d : -f 2- | cut -d '<' -f 1 | sort | uniq -c | sort -n | less

Here are the list of people with other 5 commits.  Maybe you should
need at least 10 to get a vote?

      6  Blue Swirl
      6  Kamil Dudka
      6  Michael Stefaniuc
      7  Alexey Dobriyan
      7  Damien Lespiau
      7  terra@gnome.org
      8  Arnaldo Carvalho de Melo
      8  Johannes Berg
      9  Dave Olien
     12  Pavel Roskin
     16  Alexey Zaytsev
     16  Oleg Nesterov
     20  Luc Van Oostenryck
     45  Alexander Viro
     45  Jeff Garzik
     69  Christopher Li
     75  welinder@troll.com
    124  Al Viro
    195  Josh Triplett
   1250  Linus Torvalds

regards,
dan carpenter
