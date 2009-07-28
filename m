From: Christopher Li <sparse@chrisli.org>
Subject: Re: Detect unused header files?
Date: Tue, 28 Jul 2009 14:21:02 -0700
Message-ID: <70318cbf0907281421x431d896dla3dfd9862ad3dd8a@mail.gmail.com>
References: <20090728181803.GA20845@merkur.ravnborg.org>
	 <70318cbf0907281336p47b68b5cg44a3e7206646cb80@mail.gmail.com>
	 <20090728205808.GA20955@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:58177 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178AbZG1VVD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 28 Jul 2009 17:21:03 -0400
Received: by qyk9 with SMTP id 9so275652qyk.33
        for <linux-sparse@vger.kernel.org>; Tue, 28 Jul 2009 14:21:02 -0700 (PDT)
In-Reply-To: <20090728205808.GA20955@merkur.ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: sparse <linux-sparse@vger.kernel.org>

On Tue, Jul 28, 2009 at 1:58 PM, Sam Ravnborg<sam@ravnborg.org> wrote:
> Would be great...
> If you can give some general into I can maybe give
> it a shot albeit I have only very limited sprase
> hacking knowledge.

I think the starting point is lookup_symbol().
Currently lookup_symbol does not care about where is
this symbol used. There is "sym->used" already. But it does
not help much in this case because sym->used did not distingish
the usage from the same file vs from other file.  We need to add
information some how. May be one more argument for the source
of the lookup.

>
> So if we:
> - use (check/test/reference) a macro from the file => used
> - use a typedef/struct

lookup_symbol() covers all of those. But there is annoying
part as well. For example. If the same header file get include
twice, the later one will consider using the first one because
it lookup the __HEAD_FILE_NAME__ macro to avoid duplicating
include.

Chris
