From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/3] char.c: Fix parsing of escapes
Date: Fri, 17 May 2013 11:27:49 -0700
Message-ID: <519676A5.4000706@chrisli.org>
References: <51953664.1040300@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:37718 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198Ab3EQS1x (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 17 May 2013 14:27:53 -0400
Received: by mail-pd0-f171.google.com with SMTP id t12so1854031pdi.2
        for <linux-sparse@vger.kernel.org>; Fri, 17 May 2013 11:27:53 -0700 (PDT)
In-Reply-To: <51953664.1040300@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On 05/16/2013 12:41 PM, Ramsay Jones wrote:
> 
> When parsing a string or character constant, the parse_escape()
> function returns a pointer to the character at which to resume
> parsing. However, in the case of an hex or octal escape, it was
> returning a one-past-the-end pointer. Thus, a string like:
> 
>     char str[3] = "\x61\x62\x63";
> 
> was being parsed as:
> 
>     '\x61', 'x', '6', '2', '\x63'
> 
> which, in turn, provokes an 'too long initializer' warning.
> 
> Also, fix an off-by-one error in get_char_constant() when setting
> the 'end' pointer for a TOKEN_CHAR or TOKEN_WIDE_CHAR. Despite the
> name, the string->length of the token is actually the size of the
> allocated memory (ie len+1), so we need to compensate by using
> 'token->string->length - 1'.

Great patch. Applied.

Chris

