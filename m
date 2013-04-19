From: "Kok, Auke-jan H" <auke-jan.h.kok@intel.com>
Subject: Re: [PATCH] Support #pragma once
Date: Fri, 19 Apr 2013 12:46:41 -0700
Message-ID: <CABsxX9JuiUohvN_N366y4V0qUkixzbrV3JzdKUUXsPHzYXGKhQ@mail.gmail.com>
References: <20130419191036.GA8615@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:59104 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962Ab3DSTqm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 19 Apr 2013 15:46:42 -0400
Received: by mail-qc0-f181.google.com with SMTP id a22so2259701qcs.12
        for <linux-sparse@vger.kernel.org>; Fri, 19 Apr 2013 12:46:41 -0700 (PDT)
In-Reply-To: <20130419191036.GA8615@jtriplet-mobl1>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

On Fri, Apr 19, 2013 at 12:10 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> "#pragma once" acts like a multiple-inclusion guard affecting the entire file,
> without an associated preprocessor symbol.
>
> This allows use of sparse on projects that rely on #pragma once without
> also using an ifndef-based multiple-inclusion guard, such as systemd;
> without this change, sparse will get into an include loop.
>
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>

awesome, thanks for doing this!

Auke
