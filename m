From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Support #pragma once
Date: Mon, 22 Apr 2013 09:41:02 -0700
Message-ID: <CANeU7QmNEq9+v2VFiTcPc=fPWshVrEgh5JpBz3PvvExJ4LpxYw@mail.gmail.com>
References: <20130419191036.GA8615@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:41412 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684Ab3DVQlG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Apr 2013 12:41:06 -0400
Received: by mail-ob0-f178.google.com with SMTP id 16so1646700obc.23
        for <linux-sparse@vger.kernel.org>; Mon, 22 Apr 2013 09:41:03 -0700 (PDT)
In-Reply-To: <20130419191036.GA8615@jtriplet-mobl1>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Auke Kok <auke-jan.h.kok@intel.com>

On Fri, Apr 19, 2013 at 12:10 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> "#pragma once" acts like a multiple-inclusion guard affecting the entire file,
> without an associated preprocessor symbol.
>
> This allows use of sparse on projects that rely on #pragma once without
> also using an ifndef-based multiple-inclusion guard, such as systemd;
> without this change, sparse will get into an include loop.
>

Your two patches has been applied to the chrisl repository.

Thanks

Chris
