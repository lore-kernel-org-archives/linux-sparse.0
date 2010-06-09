From: bonneta <bonneta@ensimag.fr>
Subject: Re: help for using sparse
Date: Wed, 09 Jun 2010 18:35:31 +0200
Message-ID: <6d9debf589b058363c8b89ea9248a811@ensimag.fr>
References: <cd2a19702bb05b6f27255cd697b0ea12@ensimag.fr> <20100609161058.GA4204@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx2.imag.fr ([129.88.30.17]:49071 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446Ab0FIQff (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 9 Jun 2010 12:35:35 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o59GRkAq020688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Wed, 9 Jun 2010 18:27:46 +0200
Received: from ensicom.imag.fr (web-ensimag [195.221.228.24])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o59GZVAu012514
	for <linux-sparse@vger.kernel.org>; Wed, 9 Jun 2010 18:35:31 +0200
Received: from webmail.ensimag.fr (localhost [127.0.0.1])
	by ensicom.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id o59GZVhL028363
	for <linux-sparse@vger.kernel.org>; Wed, 9 Jun 2010 18:35:31 +0200
In-Reply-To: <20100609161058.GA4204@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On Wed, 9 Jun 2010 09:10:59 -0700, Josh Triplett <josh@joshtriplett.org>
wrote:
> On Wed, Jun 09, 2010 at 05:09:54PM +0200, bonneta wrote:
>> I am working on git, and i would like to apply sparse on its source
code.
>> 
>> I've downloaded the source of sparse from its git repository, and
>> compiled
>> it successfully.
>> 
>> I've read the little documentation furnished with the code, but i
didn't
>> manage to apply sparse on the sources of git.
>> 
>> I've basically tried "sparse file.c", but it always returns with an
error
>> like :
>> "git-compat-util.h:140:11: error: unable to open 'openssl/ssl.h'"
>> or
>> "builtin/blame.c:7:10: error: unable to open 'cache.h'"
>> 
>> I don't know how to resolve it...
> 
> These errors occur because you haven't supplied the full compiler
> command-line that Git supplies in its build process, which includes
> flags for include paths.
> 
> The script "cgcc", provided with sparse, provides the most convenient
> way to integrate Sparse into an existing build system with minimal work.
> Once you've done a "make install" of Sparse into a directory on your
> $PATH (or just put the Sparse source directory on your $PATH), just do
> "make CC=cgcc".

Thank you all, it works fine.
Does sparse look for all the errors with this method?

I saw in the sparse man page that a "Wsparse-all" option exists. 
Is it used by default? Otherwise how to use it in the "make" command line?

Axel Bonnet

> 
> - Josh Triplett
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
