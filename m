From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: Add CLOG option for saving warning
Date: Sat, 19 Jul 2014 02:02:49 -0700
Message-ID: <CANeU7Q=YfKEi8WBhNoUQOXpG_6jV1KMUsq=N-rVo1maaNERyAA@mail.gmail.com>
References: <CANeU7Q=a82YmUE49uZ1sOxZn0KGLuktSXuj7YsmUb=wXQEpPXA@mail.gmail.com>
	<20140708073712.GC25880@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:33776 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756404AbaGSJCu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 19 Jul 2014 05:02:50 -0400
In-Reply-To: <20140708073712.GC25880@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>

On Tue, Jul 8, 2014 at 12:37 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> My kernel tree is full of drivers/foo.c.smatch and
> drivers/foo.c.smatch-info files...
>
> It would be nice to add it to .gitignore as well.

Actually, ".*" is already in the .gitignore, there for the sparse log files
are covered.

Chris
