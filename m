From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL] LLVM backend updates
Date: Thu, 21 Jun 2012 02:56:34 -0700
Message-ID: <CANeU7QnW=kZJrkQFy34VCxrjOZTVNs5x19t6Bryxi-bLi4KqEg@mail.gmail.com>
References: <alpine.LFD.2.02.1206091408320.4769@tux.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:41734 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759240Ab2FUJ4f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 21 Jun 2012 05:56:35 -0400
Received: by gglu4 with SMTP id u4so283733ggl.19
        for <linux-sparse@vger.kernel.org>; Thu, 21 Jun 2012 02:56:34 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1206091408320.4769@tux.localdomain>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Xi Wang <xi.wang@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, Jun 9, 2012 at 4:11 AM, Pekka Enberg <penberg@kernel.org> wrote=
:
> Hi Chris,
>
> Please pull the latest sparse-llvm tree from:
>
> =A0git@github.com:penberg/sparse-llvm.git for-chris
>
> It has one new validation test case and fixes to handle strings prope=
rly
> in the LLVM backend.

Merged and pushed on github.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
