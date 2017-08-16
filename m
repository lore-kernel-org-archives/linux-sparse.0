From: Christopher Li <sparse@chrisli.org>
Subject: Some random thoughts regarding the SSA paper
Date: Wed, 16 Aug 2017 02:33:30 -0400
Message-ID: <CANeU7QmcVS_8oko6RhG_g_97AjUNVYa=KDqDocbXL5ney=mrJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:36388 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdHPGdb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 02:33:31 -0400
Received: by mail-yw0-f171.google.com with SMTP id u207so17176740ywc.3
        for <linux-sparse@vger.kernel.org>; Tue, 15 Aug 2017 23:33:31 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

I have spend some time reading the paper

http://compilers.cs.uni-saarland.de/papers/bbhlmz13cc.pdf

"Simple and Efficient SSA Construction". Which is luc's SSA
conversion is based on:

Here is some random thoughts about the paper I might just
share with you guys. If I make a mistake some where along
the line, I am very glad if some one can point it out to me.

- I think the main point of the paper doing SSA without
  the CFG is not particular useful to us. We need to generate
  CFG *anyway*.

- The "Simple and Efficient" part has obvious limitation on
  reducible graph. Once go over the fence of irreducible graph,
   the solution is no longer simple nor efficient. For irreducible
   graph it do need the CFG. That means the CFG is actuall
   unavoidable consider source can have irreducible graph.

-  It is actually not fair to compare the fast and simple part
   with Cytron et al because
   - Cytron etc al can handle irreducible graph without extra
     complication.

   - For reducible graph, Cytron el has fast way to do it as well.
     "A Simple, Fast Dominance Algorithm" can find dominator for
      reducible graph in O(N). Once having the dominator tree,
      finding DF and inserting phi node is very straight forward.

   - For handling irreducible graph, the "Simple" paper need to
     do extra steps to clean up unneeded phi nodes.
     which runs on O(P + B =C2=B7(B + E)=C2=B7 V*V), so basiclly O(B*B*V*V)
     I think that is worse than Cytron's method.

     Because sparse need to handle irreducible graph. The worse
     case behavior need to be considered.

      BTW that is I think why the paper don't discuss handle of
      "goto" statement. "goto" can lead to irreducible graph.

- We might have a way to tell if function contain goto before
   linearized the function.

- Cytron might still be worthwhile to implement due to the better
   worse case complexity.


Chris
