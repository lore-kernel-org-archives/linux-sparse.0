From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH 1/2] sparse, llvm: Make function declaration
 accessible to backend
Date: Sat, 4 Feb 2012 07:27:41 -0800
Message-ID: <CA+55aFzd1VPDWewi7d-3kPCo-5M6ZCbZBQrgYgFbPBf9Ao7PBg@mail.gmail.com>
References: <1328090152-28299-1-git-send-email-penberg@kernel.org>
 <CANeU7Q=3mA3sjaj+rV=79qZxM_bYxDBUdMV4dECHprpKzey1Lg@mail.gmail.com>
 <4F29E0E1.3000504@garzik.org> <1328145724.28487.95.camel@pasglop>
 <CANeU7QnDStpUovGKpLdV1zw=jJc0X1LrdmeAS2x-e8xdX+J6og@mail.gmail.com>
 <1328147419.28487.96.camel@pasglop> <CANeU7Q=QwsfdTu1FhqR1TdbxLGeNWN5Qf6zEqR7M3ahNJxyEZQ@mail.gmail.com>
 <CAOJsxLHku6vzYbaOf9tPOY0VwMEcJ3Te63DYqvs+S2+-W9oFdA@mail.gmail.com>
 <CANeU7QmdK-MJofqB8frCVJHyfce07yYBU7_3cLO_8-NkEuo4tA@mail.gmail.com> <alpine.LFD.2.02.1202041455230.1744@tux.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42320 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab2BDP2C (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 4 Feb 2012 10:28:02 -0500
Received: by ggnh1 with SMTP id h1so2277433ggn.19
        for <linux-sparse@vger.kernel.org>; Sat, 04 Feb 2012 07:28:01 -0800 (PST)
In-Reply-To: <alpine.LFD.2.02.1202041455230.1744@tux.localdomain>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Christopher Li <sparse@chrisli.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jeff@garzik.org>, linux-sparse@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>

On Sat, Feb 4, 2012 at 4:56 AM, Pekka Enberg <penberg@kernel.org> wrote:
>
> Of course. Linus are you OK with the changes I did to your patch? Can I have
> your signoff before I merge it?

Sure, just add my signed-off, that patch is fine (nor do I mind the
other approach that makes it a type of a pseudo)

                Linus
