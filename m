From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 3/3] Add NOWARN and NOERR compile conditions
Date: Sat, 1 Aug 2015 10:52:17 -0700
Message-ID: <20150801175217.GA7250@x>
References: <1438216001-8862-1-git-send-email-tcamuso@redhat.com>
 <1438216001-8862-4-git-send-email-tcamuso@redhat.com>
 <20150730025502.GA1692@x>
 <55BA0E4E.7000508@redhat.com>
 <CANeU7Qm=nv85N6MWZ=Lo=OLWEmyEOOk84AHbBwFAgfUfhBonbg@mail.gmail.com>
 <55BCA8D2.1040808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:38957 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbbHARwY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 1 Aug 2015 13:52:24 -0400
Content-Disposition: inline
In-Reply-To: <55BCA8D2.1040808@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tony Camuso <tcamuso@redhat.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 01, 2015 at 07:09:06AM -0400, Tony Camuso wrote:
> On 07/31/2015 07:46 PM, Christopher Li wrote:
> >On Thu, Jul 30, 2015 at 4:45 AM, Tony Camuso <tcamuso@redhat.com> wrote:
> >>
> >>I thought it would be less intrusive, since I don't know how useful
> >>this would be to others.
> >>
> >>If you prefer a switch, I will do that.
> >
> >I agree that this should be run time behavior.
> >
> >+
> >+#if defined NOWARN || defined NOERR
> >+               return token->next;
> >+#else
> >
> >What is up with this change? It is not output warning or not.
> >It affect the parsing as well. If sparse can't bail out properly,
> >this should be a separate patch.
> >
> >Chris
> >
> 
> Hi, Chris.
> 
> I've since submitted a runtime patch (3/3 V3) with a switch as a
> response to this patch, but it basically does the same thing here.
> 
> Consider the case where the source contains something like this...
> 
> 	struct foo {
> 		union {
> 			int number;
> 			int *pointer;
> 		};
> 	};
> 
> There being no ident for the union within the struct, we get the warning,
> "missing identifier in declaration" etc.

If so, that's actually a bug in Sparse; anonymous unions should be
allowed without warning:

$ cat test.c
struct foo {
    union {
        int number;
        int *pointer;
    };
};
$ gcc -Wall -Wextra -c test.c -o /dev/null
$

They have a well-defined semantic meaning, and they're standardized in
C11, just not in C89 or C99.

- Josh Triplett
