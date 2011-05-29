From: Avi Kivity <avi@redhat.com>
Subject: Re: vector_size attribute?
Date: Sun, 29 May 2011 19:26:24 +0300
Message-ID: <4DE273B0.7000800@redhat.com>
References: <20110529085726.c0234647.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24882 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936Ab1E2Q02 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 29 May 2011 12:26:28 -0400
In-Reply-To: <20110529085726.c0234647.rdunlap@xenotime.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-sparse@vger.kernel.org

On 05/29/2011 06:57 PM, Randy Dunlap wrote:
> Current Linux mainline generates a ton of sparse warnings like
>
> arch/x86/include/asm/kvm_emulate.h:194:28: error: attribute 'vector_size': unknown attribute
>
> from this source line:
>
> typedef u32 __attribute__((vector_size(16))) sse128_t;

I guess sparse should be taught about it.  It's needed so that gcc asm 
constraints are aware of what memory is touched when running an sse 
instruction.

(probably ignoring it for now should be sufficient)

-- 
error compiling committee.c: too many arguments to function

