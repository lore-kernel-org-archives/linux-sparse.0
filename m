From: Chris Li <christ.li@gmail.com>
Subject: Re: [PATCH] show_token: handle TOKEN_UNTAINT and TOKEN_ARG_COUNT
	types
Date: Tue, 11 Aug 2009 13:39:06 -0700
Message-ID: <70318cbf0908111339u75597849o7e037d17aee9a46@mail.gmail.com>
References: <87tz0ek0is.fsf@faui44a.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f172.google.com ([209.85.212.172]:46033 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804AbZHKUjG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Aug 2009 16:39:06 -0400
Received: by vws2 with SMTP id 2so3624743vws.4
        for <linux-sparse@vger.kernel.org>; Tue, 11 Aug 2009 13:39:06 -0700 (PDT)
In-Reply-To: <87tz0ek0is.fsf@faui44a.informatik.uni-erlangen.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Reinhard Tartler <siretart@tauware.de>
Cc: linux-sparse@vger.kernel.org

On Thu, Apr 30, 2009 at 2:08 PM, Reinhard Tartler<siretart@tauware.de> wrote:
>
> These cases are probably never hit with "regular" codepaths, but are
> useful when called in a gdb session to print token sequences.
>
> Signed-off-by: Reinhard Tartler <siretart@tauware.de>

Thanks, applied.

Chris
