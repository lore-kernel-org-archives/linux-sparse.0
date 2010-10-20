From: Bernd Petrovitsch <bernd@sysprog.at>
Subject: Re: including sparse headers in C++ code
Date: Wed, 20 Oct 2010 12:19:02 +0200
Message-ID: <1287569942.7542.8.camel@thorin>
References: <20101011224656.GN19804@ZenIV.linux.org.uk>
	 <AANLkTinWYFf0CqBt9FJ9QyeGCU6754GotQM06U4vMqRa@mail.gmail.com>
	 <AANLkTimdy9TwwSJM=rwTjXdRsnove6A2b0=d4M_dOin0@mail.gmail.com>
	 <AANLkTimhh3zj8kgvaSQq9_CS711mLw8skrWL4yUgvJzT@mail.gmail.com>
	 <AANLkTimZb1PsnKcMQ_Ka6dkk7fNwXiJb6_U4GcckLsF4@mail.gmail.com>
	 <20101016191153.GA19324@feather>
	 <AANLkTi=tpKLvWh6VKsizpZaxYMBntaGU1gC5uRu1_bND@mail.gmail.com>
	 <20101018053955.GA1628@feather>
	 <AANLkTim2ti8+aht_f=Mv=0iLZCvF65CFF6GNP2gHF=Kq@mail.gmail.com>
	 <AANLkTinuRiaMZExudng5ECeunmF4s2ptnfaE=fYBft=i@mail.gmail.com>
	 <20101019213109.GV19804@ZenIV.linux.org.uk>
	 <AANLkTi=QryvTC=Q3xsNh4fyhT3V-WZ1VSaE4=JPntz=n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:2226 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751251Ab0JTKTL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 20 Oct 2010 06:19:11 -0400
In-Reply-To: <AANLkTi=QryvTC=Q3xsNh4fyhT3V-WZ1VSaE4=JPntz=n@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tomas Klacko <tomas.klacko@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Mit, 2010-10-20 at 00:49 +0200, Tomas Klacko wrote: 
> On Tue, Oct 19, 2010 at 11:31 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Tue, Oct 19, 2010 at 10:03:42PM +0200, Tomas Klacko wrote:
> 
> >>  static inline int match_op(struct token *token, int op)
> >>  {
> >> -     return token->pos.type == TOKEN_SPECIAL && token->special == op;
> >> +     return token->pos.type == TOKEN_SPECIAL && token->special == (unsigned int)op;
> >
> > What was that one for?
> 
> "warning: comparison between signed and unsigned integer expressions"

Add "-Wsign-compare" to the CFLAGS (for a pure C compile) and you will
find many more of them.
IMHO it needs a decision if the goal is to prefer signed or unsigned int
(where no negative values ever used/assigned) and convert struct members
and/or global variables. Most of them TTBOMK are never negative anyways.

For the "C vs C++" issue: if you have an enum, the rules (or at least
the reality defined by gcc) are subtly different if it's a signed int or
an unsigned int and the values of their members.

Bernd
-- 
mobile: +43 664 4416156              http://www.sysprog.at/
    Linux Software Development, Consulting and Services


