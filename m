From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [GIT PULL] llvm fixes
Date: Mon, 30 Oct 2017 07:14:30 +0100
Message-ID: <20171030061429.uwdyfzjrr52hx6p3@ltop.local>
References: <20170918095135.12066-1-luc.vanoostenryck@gmail.com>
 <CANeU7QmSeq8x4D3KK4_qkfjzb1T+4J=bJsnKNggBZrh6wC7n8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:54253 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbdJ3GOd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 30 Oct 2017 02:14:33 -0400
Received: by mail-wm0-f45.google.com with SMTP id r196so13981043wmf.2
        for <linux-sparse@vger.kernel.org>; Sun, 29 Oct 2017 23:14:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QmSeq8x4D3KK4_qkfjzb1T+4J=bJsnKNggBZrh6wC7n8Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Oct 30, 2017 at 07:31:28AM +0800, Christopher Li wrote:
> On Mon, Sep 18, 2017 at 5:51 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Chris,
> >
> > Please, pull these patches for master.
> 
> Ah, I can't find the exact corresponding patch series in the email.
> So I will just comment from the git change.
> =========quote===========
> commit ae7fd3b06c225fd8faf67c3e20db07b64eca7fc3
>  don't output value of anonymous symbol's pointer
> 
>     The value of this pointer is of no use unless you're
>     using a debugger (or just to see if two things are
>     identical or not) and it's presence produces noise
>     when comparing the output of two runs for testing.
> 
>     Change this by issuing it only if 'verbose' is set.
> diff --git a/linearize.c b/linearize.c
> index 42d1680..b69f838 100644
> --- a/linearize.c
> +++ b/linearize.c
> @@ -120,7 +120,7 @@ const char *show_pseudo(pseudo_t pseudo)
>                         break;
>                 }
>                 expr = sym->initializer;
> -               snprintf(buf, 64, "<anon symbol:%p>", sym);
> +               snprintf(buf, 64, "<anon symbol:%p>", verbose ? sym : NULL);
> =======================================================
> 
> Very trivial feed back:
> 
> I think it is better not print out the %p for NULL.
> Just skip the %p if not verbose was set.

Skipping the '%p' is more complex than what the patch here is doing.
Printing the NULL has also the advantage to have the same output format
which is usefull when the output is analysed by scripts.
 
> BTW, I understand you are reluctant to make trivial change to very
> old series of branch. That make sense.

Yes, "old series" is the keywords here: this series have been posted
in March, 7 months ago, and have never received any feedback.

> In that case, I can make a topic branch to track the feedback and fix up
> as incremental change. Then integrate that branch when all the feedback
> settle down. I don't mind writing some feedback patches myself if
> you prefer.

Well, given it has taken 7 months to have the first feedback, the
usefulness of this feedback and given the 'speed' at wich you handle
patches, pull requests or questions, I wonder how much months or years
this will take (and this series is only the very first one, many others
are waiing, albeit smaller ones, totalling about 230-400 patches).

If it wasn't clear yet: nor the quality of your feedback, nor its 'speed'
is of any use for doing development, on the contrary.

-- Luc
