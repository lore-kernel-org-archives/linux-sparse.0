From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3 4/7] add a method to external_declaration()
Date: Mon, 6 Mar 2017 09:13:09 +0800
Message-ID: <CANeU7QnLNys3aO_1Bvtb3VPOU8UC-vYX3QJEhUrg-s_Dga-fZg@mail.gmail.com>
References: <20170228094635.qbod5dwqwrw6etvt@macbook.local>
 <20170228100403.33184-1-luc.vanoostenryck@gmail.com> <20170228100403.33184-5-luc.vanoostenryck@gmail.com>
 <CANeU7Qk34VzZ6Q2oxEcFrreK=NOwmpSGbiVgvyckpp154xWJaQ@mail.gmail.com> <20170305151220.rsfs5wpdfixhstor@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:36072 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752398AbdCFBVN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 20:21:13 -0500
Received: by mail-it0-f53.google.com with SMTP id h10so40869921ith.1
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 17:21:12 -0800 (PST)
In-Reply-To: <20170305151220.rsfs5wpdfixhstor@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 5, 2017 at 11:12 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> And to be honest, the current name 'external_declaration()' is far
> from being a good name eithers: it doesn't give a hint on *what*
> the function is doing and it's not only for 'extern' declaration.

Actually, external_declaration is a GREAT name. The reason is that,
it is base on the C grammar  BNF form.

<external-declaration> ::= <function-definition>
                         | <declaration>

It consume just enough token to complete a "<external-declaration>".

Same as a lot of other sparse parser function name.
"struct-or-union", "pointer" etc. In that regard, it is following a consistent
naming scheme. It is easier to match code to the BNF form.
Conceptional clear about what the code supposed to do.

I did not come up with that, Linus did.

Chris
