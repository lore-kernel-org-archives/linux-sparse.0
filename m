Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEADB186284
	for <linux-sparse@vger.kernel.org>; Thu, 19 Mar 2026 05:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773898311; cv=none; b=HWPUci0cVBIVZnvXPkooC+C5hfSo/IVPkOWJ0tJqHrq8FxpEGf8Ns7UXIoRAVyXnH84+shV0pi1VuQZi6t2bvSci82LRYUmLli0Ln46rezP6Dv0T1Z1h3K4C1YZpzvqxP3x4u9Wv+atnB12ctndYJ+01ImBq5mjqJVbIVhEz1Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773898311; c=relaxed/simple;
	bh=NmeriAPvj0DEs79aRIYZsDYk8hwYQDJE8CtNo6N2lw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaRXuj/T2oX3kA0Z7/Jq/crAcCtK3UZ2RwfTP8rt0S0Eqc9VpnSupalGnKQxtA0iP/ZoNOhY2R9yUEga8FbJznIfw1fpoRtGGvxBqDywTMOlDgYfD679Tmq/xrlmaeN68q4VU8m8Snn9FsA4SteSkBSWXaxhpksA0Cwgg/2VXDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OSB9cOYy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OSB9cOYy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=whFi9ry4qpeNN3gs0ebpoM8JrTCtvHPj/8Q7Lrbo/zg=; b=OSB9cOYyyzRzWzW6RGGhL+khRS
	uSf5MpUzexY6NPUKF1IuPg7VAWh4/gZ563q5fT5Zo+kBUIYFZsGcJQRJ7wqwtT441fSj6qNyuk5TX
	alHK2JONKUqZgf0yFspfIZfy4CtYGYSkQjXmYPvPdA9zpkYObG/n96eoPLDUkbVylL5xjM8NPRxmS
	xK0x+Z/v1Vv+ikI+K/u0C/VIvyD+S8r1ewgfcln5IS1bVLA4JvhU4zG/0nmxO67A44uB/AdKL4Y5t
	3hqGitro7Cqre0gATweukMh/GNny5A7+LagRauePQV6D1e3g/Gf7LA0nNZnUI1Xjkp3X0kK72Wcim
	wKUTmk4Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w3625-0000000Ek31-0Udk;
	Thu, 19 Mar 2026 05:34:57 +0000
Date: Thu, 19 Mar 2026 05:34:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Zhang <zxh@xh-zhang.com>, linux-sparse@vger.kernel.org,
	dan.carpenter@linaro.org, chriscli@google.com,
	ben.dooks@codethink.co.uk, rf@opensource.cirrus.com
Subject: Re: [RFC PATCH] pre-process: add __VA_OPT__ support
Message-ID: <20260319053457.GH3836593@ZenIV>
References: <20260225072731.GA3093958@ZenIV>
 <20260225081413.2480484-1-zxh@xh-zhang.com>
 <20260225221851.GE1762976@ZenIV>
 <20260226072945.GA4104757@ZenIV>
 <20260316065622.GA607739@ZenIV>
 <CAHk-=wghBU1bB6E889nv5fg+40b4_n5WnA0h3bVh32EKw0zE2w@mail.gmail.com>
 <20260319035324.GG3836593@ZenIV>
 <CAHk-=wh7zNVQ0k1o_3cgGiCdcpYFCvbZ2O3ZLQW-q2xXqusmww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wh7zNVQ0k1o_3cgGiCdcpYFCvbZ2O3ZLQW-q2xXqusmww@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Mar 18, 2026 at 09:07:17PM -0700, Linus Torvalds wrote:

> I looked at clang at one point, and iirc it generated *much* better
> code, because I think it does tth esmart thing, which is to get rid of
> the notion of bitfields as quickly as possible, and then doing just
> regular integer optimizations.

FWIW, with the local tokenizer patches the single worst spot at the moment
(both for clang and for gcc build) is this:
        p = &hash_table[hash];
	while ((ident = *p) != NULL) {
		if (ident->len == (unsigned char) len) {
in create_hashed_ident().  This is from clang build, where
it's inlined into tokenize_stream():
   0.14 │       mov    (%rdx,%rcx,8),%rax                                                                                           
  12.34 │       mov    %r12d,%r15d                                                                                                  
   0.02 │       test   %rax,%rax                                                                                                    
   0.43 │     ↓ je     33e                                                                                                          
        │       mov    %rsp,%r14                                                                                                    
   0.29 │     ↓ jmp    319                                                                                                          
        │       nop                                                                                                                 
        │310:┌─→mov    0x0(%r13),%rax                                                                                               
   2.00 │    │  test   %rax,%rax                                                                                                    
   0.07 │    │↓ je     345                                                                                                          
   0.00 │319:│  mov    %rax,%r13                                                                                                    
        │    │if (ident->len == (unsigned char) len) {                                                                              
   0.19 │    ├──cmp    %r12b,0x10(%rax)                                                                                             
  16.86 │    └──jne    310                                                                                                          
and this is gcc build, where it's not inlined, so the percentages are
several times higher (out of 5.9% vs. out of 17.1% on the profiles I'm
looking at):
        │    p = &hash_table[hash];                                                                                                ▒
   0.77 │      mov    (%rax,%rdx,8),%rbx                                                                                           ▒
        │    while ((ident = *p) != NULL) {                                                                                        ▒
  27.77 │      test   %rbx,%rbx                                                                                                    ◆
   0.98 │    ↓ jne    3b                                                                                                           ▒
        │    ↓ jmp    c2                                                                                                           ▒
        │      nop                                                                                                                 ▒
        │    ident_hit++;                                                                                                          ▒
        │    return ident;                                                                                                         ▒
        │    }                                                                                                                     ▒
        │    next:                                                                                                                 ▒
        │    //misses++;                                                                                                           ▒
        │    p = &ident->next;                                                                                                     ▒
   0.00 │30:┌─→mov    (%rbx),%rax                                                                                                  ▒
        │   │while ((ident = *p) != NULL) {                                                                                        ▒
   6.11 │   │  test   %rax,%rax                                                                                                    ▒
   0.24 │   │↓ je     70                                                                                                           ▒
        │   │  mov    %rax,%rbx                                                                                                    ▒
        │   │if (ident->len == (unsigned char) len) {                                                                              ▒
   0.81 │3b:├──cmp    %bpl,0x10(%rbx)                                                                                              ▒
  50.82 │   └──jne    30                                                                                                           ▒

Most of the accesses are to single-element chain; it's not walking the
lists that hurts, it's the very first step.  The profiles are for userland
cycles; looking for stalled-cycles-frontend gives exact same hotspots.
The next one is lookup_symbol(); there we also walk linked lists.
The only difference is that lists are often longer than one entry...
Not sure what can be done about either.
