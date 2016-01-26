From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 07/13] evaluate: check static storage duration
 objects' intializers' constness
Date: Tue, 26 Jan 2016 18:56:39 +0100
Message-ID: <20160126175637.GB989@macpro.local>
References: <87twm1g1go.fsf@gmail.com>
 <87zivtemfq.fsf@gmail.com>
 <20160126014227.GE46188@macpro.local>
 <87h9i0b9xr.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35458 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756092AbcAZR4m (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Jan 2016 12:56:42 -0500
Received: by mail-wm0-f67.google.com with SMTP id 123so18784417wmz.2
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2016 09:56:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87h9i0b9xr.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Tue, Jan 26, 2016 at 05:08:16PM +0100, Nicolai Stange wrote:
> Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:
> > Better here also to split the patch in two:
> > one add the -W flag flag and another one which will use it.
> 
> Introducing a flag without any functionality attached to it feels wrong
> for me. For example, where to update the manpage? Before or after actual
> functionality is introduced?

For me it's fine when it's all part of the same serie.
The update to the manpage should be done when adding the flag,
before using it.
 

> >> @@ -2633,6 +2647,16 @@ static int handle_simple_initializer(struct expression **ep, int nested,
> > ...
> >> +			warning(e->pos, "initializer for static storage duration object is not a constant expression");
> >
> > This is quite longish message.
> > What about something like "non-constant initializer"?
> 
> That could be misleading:
> 
>   static const int a = 1;
>   static const int b = a;
> 
> is forbidden, but obiously, 'a' is constant.
> 
> I'd like to keep the C99 term "constant expression", as well as
> "initializer" and "static".
> 
> I could s/storage duration//.

Or "non-constant initializer for static object"?

> >> +int Wstatic_initializer_not_const = 0;
> >
> > Here also it's quite longish. Yes I'm a lazy typer :)
> > What about simply -Wconst-initializer ?
> 
> Josh Triplett wrote in his replies to my RFC series:
>   Shouldn't it be something like -Wnon-constant-initializer,
>   since that's what it checks for?
> 
> I conclude that we generally want to have -Wwhat-is-checked.
> Now, it is the *non*-constant initializers that are being checked for.
> 
> Unfortunately, -WnoXXXXXXX seems to get misinterpreted as "switch
> XXXXXXX" off by sparse's command line parsing.
> In this case "switch n-constant-initializer off".
> (I did not verify that by reading code, just by trying it out and
> failing, so just a guess).

Yes the code disable warning flags that begin by 'no' or 'no-' .

I see things a bit more loosely: -Wfoobar could means that we will check
and warn something related to 'foobar' but yes it's certainly better
to keep the logic in the direction "warn if 'foobar' is encountered".

> The -Wstatic-initializer-not-const choice made in the current series is
> simply a workaround, any better suggestions welcome!
> 
> I'm also fine with -Wstatic-initializer.
> 
> Comments?

I dunno.
Better to leave it so for now, I think.


Luc
