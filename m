From: "Marko Kreen" <markokr@gmail.com>
Subject: Re: confusing shift warning
Date: Fri, 25 Apr 2008 11:03:09 +0300
Message-ID: <e51f66da0804250103y4c5abbaby2c8a43db7ba5d04f@mail.gmail.com>
References: <e51f66da0804250053x2ec991dbu9a5a54fdcbea2a2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:5619 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756923AbYDYIDN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 Apr 2008 04:03:13 -0400
Received: by fk-out-0910.google.com with SMTP id 19so4798861fkr.5
        for <linux-sparse@vger.kernel.org>; Fri, 25 Apr 2008 01:03:11 -0700 (PDT)
In-Reply-To: <e51f66da0804250053x2ec991dbu9a5a54fdcbea2a2a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On 4/25/08, Marko Kreen <markokr@gmail.com> wrote:
> Platform: x64_64 linux, uint64_t -> unsigned long
>  Sparse: today's git (6dcc36a)

Oh, and another warning:

#include <sys/socket.h> gives:

 /usr/include/bits/socket.h:159:5: warning: constant
9223372036854775807L is so big it is long long

I used to ignore it as it was not in my code, but its probably same thing.

Ubuntu 8.04
gcc 4:4.2.3-1ubuntu3
glibc 2.7-10ubuntu3
linux-headers - 2.6.24-16.30

-- 
marko
