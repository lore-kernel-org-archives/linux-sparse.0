From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Makefile: fix permissions mixup on install
Date: Tue, 27 Oct 2009 21:05:18 -0700
Message-ID: <70318cbf0910272105p60bb4623td07c870c0a9bfb4a@mail.gmail.com>
References: <449c10960910271737s4acf67dfsf29daf25fed9b53b@mail.gmail.com>
	 <1256690768-2577-1-git-send-email-dan@archlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f180.google.com ([209.85.223.180]:56277 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbZJ1EFO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 28 Oct 2009 00:05:14 -0400
Received: by iwn10 with SMTP id 10so337331iwn.4
        for <linux-sparse@vger.kernel.org>; Tue, 27 Oct 2009 21:05:18 -0700 (PDT)
In-Reply-To: <1256690768-2577-1-git-send-email-dan@archlinux.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan McGee <dan@archlinux.org>
Cc: linux-sparse@vger.kernel.org

On Tue, Oct 27, 2009 at 5:46 PM, Dan McGee <dan@archlinux.org> wrote:
> `install` by default uses 755 permissions; for everything but executa=
bles we
> want to use 644 permissions.

So far so good.

> -define INSTALL_CMD
> +define INSTALL_PROG

I rename it to INSTALL_EXEC and INSTALL_FILE respectively.

> =A0 =A0 =A0 =A0$(Q)$(QUIET_INST_SH)install -v $1 $(DESTDIR)$2/$1 || e=
xit 1;
> +endef

Your patch remove a newline which is critical here. It is very subtle w=
hen
using it inside a $(foreach ) loop. $(foreach ) blindly concatenate loo=
p both.
'@' only have special meaning after a newline. I get "@echo" command
not found without this new line.

The others look good. I apply a version with the rename and newline
changes in chrisl branch. Let me know that works for you or not.
If you have other feed back of the change, I can still change it.

Thanks

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
