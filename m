From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 4/5] Fix some "plain integer as NULL pointer" warnings on
	cygwin
Date: Tue, 21 Jul 2009 17:37:22 -0700
Message-ID: <70318cbf0907211737i42ae4b29u7fc4b4c9d32f6b6c@mail.gmail.com>
References: <4A623766.5020002@ramsay1.demon.co.uk>
	 <70318cbf0907201331v1c830779i89c9bef9d6706115@mail.gmail.com>
	 <4A6638FF.4000108@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f173.google.com ([209.85.221.173]:39661 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbZGVAhW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 Jul 2009 20:37:22 -0400
Received: by qyk3 with SMTP id 3so1421360qyk.33
        for <linux-sparse@vger.kernel.org>; Tue, 21 Jul 2009 17:37:22 -0700 (PDT)
In-Reply-To: <4A6638FF.4000108@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Tue, Jul 21, 2009 at 2:54 PM, Ramsay Jones<ramsay@ramsay1.demon.co.uk> wrote:
> This is on cygwin. (as mentioned in the subject;P)

Sorry I miss the most obvious spot :-). Let me take a look.

Chris
