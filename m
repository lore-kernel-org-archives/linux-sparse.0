From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] linux/compiler.h: Add __must_hold macro for functions
 called with a lock held
Date: Tue, 9 Oct 2012 13:06:37 -0700
Message-ID: <20121009130637.5e61078f.akpm@linux-foundation.org>
References: <20121008020610.GA9197@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:55135 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab2JIUGj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Oct 2012 16:06:39 -0400
In-Reply-To: <20121008020610.GA9197@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, Ed Cashin <ecashin@coraid.com>, Christopher Li <sparse@chrisli.org>, Andi Kleen <ak@linux.intel.com>

On Sun, 7 Oct 2012 19:06:10 -0700
Josh Triplett <josh@joshtriplett.org> wrote:

> linux/compiler.h has macros to denote functions that acquire or release
> locks, but not to denote functions called with a lock held that return
> with the lock still held.  Add a __must_hold macro to cover that case.

hum.  How does this work?  Any code examples and sample sparse output? 
Does it apply to all lock types, etc?

IOW, where is all this stuff documented?

