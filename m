From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] parser: add Blackfin gcc info
Date: Wed, 6 Oct 2010 19:24:41 -0700
Message-ID: <AANLkTimC+9VeiZ6rszO6B7hg5tG+TzsQy-XjK5T0pKuz@mail.gmail.com>
References: <1286410188-6074-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:32998 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759840Ab0JGCYm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Oct 2010 22:24:42 -0400
Received: by gwj17 with SMTP id 17so97821gwj.19
        for <linux-sparse@vger.kernel.org>; Wed, 06 Oct 2010 19:24:41 -0700 (PDT)
In-Reply-To: <1286410188-6074-1-git-send-email-vapier@gentoo.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-sparse@vger.kernel.org

On Wed, Oct 6, 2010 at 5:09 PM, Mike Frysinger <vapier@gentoo.org> wrot=
e:
> The Blackfin port uses some custom attributes to control memory place=
ment,
> and it has some custom builtins. =A0So add the ones that the kernel a=
ctually
> utilizes to avoid massive build errors with sparse.


The change looks good. Will apply.

Thanks for the patch.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
