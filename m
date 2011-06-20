From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: Add 'artifical' to ignore attributes
Date: Mon, 20 Jun 2011 10:36:00 -0700
Message-ID: <BANLkTim8ZSN2=CHfidFhRC0G4OkkWi-dbA@mail.gmail.com>
References: <1308500451-22637-1-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50245 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244Ab1FTRgB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 20 Jun 2011 13:36:01 -0400
Received: by wwe5 with SMTP id 5so2788658wwe.1
        for <linux-sparse@vger.kernel.org>; Mon, 20 Jun 2011 10:36:00 -0700 (PDT)
In-Reply-To: <1308500451-22637-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org

On Sun, Jun 19, 2011 at 9:20 AM, Pekka Enberg <penberg@kernel.org> wrote:
> This patch adds the 'artifical' GCC attribute to list of ignore attributes.
> It's an attribute that's used by glibc which causes the following bogus sparse
> warnings when using it for userspace projects:

Thanks for the patch. It  looks good. Will apply.

Chris
