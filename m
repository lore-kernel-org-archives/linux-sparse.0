From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] thread_info: suppress sparse warning in check_copy_size()
Date: Fri, 28 Jul 2017 11:16:49 +0200
Message-ID: <CAExDi1QnPdUfrLgAzJUq=4ZQ9r+cLF26oyq=rm20bLj0XAYZiQ@mail.gmail.com>
References: <1501108037-14429-1-git-send-email-abdallah.meziti.pro@gmail.com> <CAADWXX8b3rJZBBv5V+eoSpC-073Peh4nnTxoJWjMJTbkasSTJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:37564 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbdG1JQv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 28 Jul 2017 05:16:51 -0400
In-Reply-To: <CAADWXX8b3rJZBBv5V+eoSpC-073Peh4nnTxoJWjMJTbkasSTJg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: AbdAllah-MEZITI <abdallah.meziti.pro@gmail.com>, luto@kernel.org, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kyle Huey <me@kylehuey.com>, Sahara <keun-o.park@darkmatter.ae>, Al Viro <viro@zeniv.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Lance Richardson <lrichard@redhat.com>, Johannes Berg <johannes@sipsolutions.net>

On Thu, Jul 27, 2017 at 12:41 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> This is wrong. The sparse version of __compiletime_object_size()
> should just be fixed to take a 'const' pointer without complaints.

The underlying __builtin_object_size() has been fixed in the sparse tree
6 months ago or so.

-- Luc
