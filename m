From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCHv2] Rename -Wall to Wsparse-all, so it doesn't get turned
	on unintentionally
Date: Sun, 11 Oct 2009 22:46:25 -0700
Message-ID: <70318cbf0910112246w3cdb386fjc12f0be4ff135220@mail.gmail.com>
References: <20091011224618.GA3963@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f203.google.com ([209.85.212.203]:62985 "EHLO
	mail-vw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbZJLFrB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 12 Oct 2009 01:47:01 -0400
Received: by vws41 with SMTP id 41so4656131vws.4
        for <linux-sparse@vger.kernel.org>; Sun, 11 Oct 2009 22:46:25 -0700 (PDT)
In-Reply-To: <20091011224618.GA3963@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-sparse@vger.kernel.org

On Sun, Oct 11, 2009 at 3:47 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> v2: Update cgcc and remove unnecessary (and now ignored) -Wall from a
> test case.

Applied. BTW, what do you think about moving the logic from cgcc into
sparse directly?

Chris
