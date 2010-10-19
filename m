From: David Malcolm <dmalcolm@redhat.com>
Subject: Re: including sparse headers in C++ code
Date: Tue, 19 Oct 2010 17:46:44 -0400
Message-ID: <1287524804.3483.26.camel@radiator.bos.redhat.com>
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
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7232 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753247Ab0JSVrv (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Oct 2010 17:47:51 -0400
In-Reply-To: <20101019213109.GV19804@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Tomas Klacko <tomas.klacko@gmail.com>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Tue, 2010-10-19 at 22:31 +0100, Al Viro wrote:
> On Tue, Oct 19, 2010 at 10:03:42PM +0200, Tomas Klacko wrote:
> > @@ -188,7 +188,7 @@ static struct symbol_op char_op = {
> >  	.type = KW_SPECIFIER,
> >  	.test = Set_T|Set_Long|Set_Short,
> >  	.set = Set_T|Set_Char,
> > -	.class = CChar,
> > +	.klass = CChar,
> >  };
> 
> Egads...  Why not "kC1455", while you are at it?  Seriously, if you feel the
> need to rename that, at least use something more palatable.  Hell, even
> adjust_type would be better...
FWIW, "klass" is used as a spelling of "class" in .c code by Ruby, by
the GTK/GNOME stack, Mono, OpenJDK, Dalvik, and others.

See e.g.:
http://www.google.com/codesearch?hl=en&start=20&sa=N&as_case=y&q=klass+lang:c


