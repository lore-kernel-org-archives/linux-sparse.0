From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: including sparse headers in C++ code
Date: Wed, 20 Oct 2010 08:40:34 +0100
Message-ID: <20101020074034.GY19804@ZenIV.linux.org.uk>
References: <AANLkTimdy9TwwSJM=rwTjXdRsnove6A2b0=d4M_dOin0@mail.gmail.com>
 <AANLkTimhh3zj8kgvaSQq9_CS711mLw8skrWL4yUgvJzT@mail.gmail.com>
 <AANLkTimZb1PsnKcMQ_Ka6dkk7fNwXiJb6_U4GcckLsF4@mail.gmail.com>
 <20101016191153.GA19324@feather>
 <AANLkTi=tpKLvWh6VKsizpZaxYMBntaGU1gC5uRu1_bND@mail.gmail.com>
 <20101018053955.GA1628@feather>
 <AANLkTim2ti8+aht_f=Mv=0iLZCvF65CFF6GNP2gHF=Kq@mail.gmail.com>
 <AANLkTinuRiaMZExudng5ECeunmF4s2ptnfaE=fYBft=i@mail.gmail.com>
 <20101019213109.GV19804@ZenIV.linux.org.uk>
 <AANLkTin1VwzZ=nwEpfxD4WBXjo=Pyn0a+s=DnsSvQOg8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:56202 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162Ab0JTHkh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 20 Oct 2010 03:40:37 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTin1VwzZ=nwEpfxD4WBXjo=Pyn0a+s=DnsSvQOg8@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Tomas Klacko <tomas.klacko@gmail.com>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Tue, Oct 19, 2010 at 04:07:42PM -0700, Christopher Li wrote:
> On Tue, Oct 19, 2010 at 2:31 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Tue, Oct 19, 2010 at 10:03:42PM +0200, Tomas Klacko wrote:
> >> @@ -188,7 +188,7 @@ static struct symbol_op char_op = {
> >> ? ? ? .type = KW_SPECIFIER,
> >> ? ? ? .test = Set_T|Set_Long|Set_Short,
> >> ? ? ? .set = Set_T|Set_Char,
> >> - ? ? .class = CChar,
> >> + ? ? .klass = CChar,
> >> ?};
> >
> > Egads... ?Why not "kC1455", while you are at it? ?Seriously, if you feel the
> > need to rename that, at least use something more palatable. ?Hell, even
> > adjust_type would be better...
> 
> I suggested the "klass", my bad. How about your suggest a perfect name
> and we will use it. Is "adjust_type" good enough?

type_group, probably...  FWIW, I'd probably spell that enum in parse.c as
	CInt = 0, CSInt = 1, CUInt = 2, CReal = 3, CChar = 4,
	CSChar = CChar + CSInt, CUChar = CChar + CUInt
while we are at it.
