From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH-v2 2/4] Replace SYM_ and MOD_ #defines with enums in
	symbol.h.
Date: Tue, 2 Jun 2009 13:44:20 -0700
Message-ID: <70318cbf0906021344w2adcf585g7d7adcd320d66fa9@mail.gmail.com>
References: <1243881445-30069-1-git-send-email-naesten@gmail.com>
	 <1243881445-30069-2-git-send-email-naesten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:8550 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829AbZFBUoS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 2 Jun 2009 16:44:18 -0400
Received: by wf-out-1314.google.com with SMTP id 26so2982585wfd.4
        for <linux-sparse@vger.kernel.org>; Tue, 02 Jun 2009 13:44:20 -0700 (PDT)
In-Reply-To: <1243881445-30069-2-git-send-email-naesten@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Samuel Bronson <naesten@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Mon, Jun 1, 2009 at 11:37 AM, Samuel Bronson <naesten@gmail.com> wrote:
> Adjust the associated fields to match. While we're here, change
> some nearby bitfields from "char" to "int" so GDB doesn't bother
> showing character literals for them.

> +enum modifier {
> +       MOD_AUTO        = 1 << 0,

The patch does not apply to my tree. The modifier is definitely not
an enum because we apply bit operation to it.

Changing bitfield from "char" to "int" has risk of making the symbol
struct bigger. We don't want that because symbol is a very common
structure for sparse.

Chris
