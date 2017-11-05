From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [GIT PULL] llvm fixes
Date: Sun, 5 Nov 2017 18:10:15 +0100
Message-ID: <20171105171013.mktkihyuuagqthaq@ltop.local>
References: <20170918095135.12066-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qnu7h09YHhGVOY3r4M9FNOvOrs+kB_yJT-i0cSeLtKhAw@mail.gmail.com>
 <CANeU7QnFkJC4YePAdSTmKXNKiraCZHKJPSaNbKVPqdf01NhrYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:52070 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdKERKS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 12:10:18 -0500
Received: by mail-wm0-f51.google.com with SMTP id b9so9977640wmh.0
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 09:10:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QnFkJC4YePAdSTmKXNKiraCZHKJPSaNbKVPqdf01NhrYg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Nov 05, 2017 at 04:29:57PM +0800, Christopher Li wrote:
> >commit e4a0824120939235e40277a57425a72fbfcd5b9b
> >Author: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> >Date:   Sun Mar 26 19:35:14 2017 +0200
> >
> 
> I think this patch ideally should be combined with the next patch.
> As it is, this patch is not self contain. There is no user of this table.

I'm fine with this. Certainly when:
*) the user is introduced in the next patch  
*) there is 'static but unused' warnings issued

> ...
> > static int simplify_seteq_setne(struct instruction *insn, long long value)
> > {
> >       pseudo_t old = insn->src1;
> >@@ -484,7 +460,7 @@ static int simplify_seteq_setne(struct instruction *insn, long long value)
> >               // and similar for setne/eq ... 0/1
> >               src1 = def->src1;
> >               src2 = def->src2;
> >-              insn->opcode = compare_opcode(opcode, inverse);
> >+              insn->opcode = inverse ? opcode_table[opcode].negate : opcode;
> 
> I think it would be better to have some kind of assert check here, the opcode
> you swap from the table is indeep opcode. Because you assign the opcode
> array using sparse index. It is easy to miss a spot creating the empty slot in
> the table.

Sorry, I see the words, I sorta gues what you mean but I can't parse
what you wrote.

> Also, the opcode table might be able to compressed only contain
> section of the BINCMP opcodes.

Yes, it's something that may be done after all the related changes
are done if the speedup is worth the added complexity.

-- Luc
