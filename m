From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 07/13] llvm: fix output OP_ADD mixed with pointers
Date: Mon, 6 Mar 2017 17:43:07 +0100
Message-ID: <20170306164306.hibukuy2t4j4camh@macpro.local>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
 <20170305112047.3411-8-luc.vanoostenryck@gmail.com>
 <CANeU7Qk6xjhNPVZWxTB4iOavH5=bha+a_utz7+PJuSTo1WKgOg@mail.gmail.com>
 <CACXZuxfX0TiYGJDewbRW9Tr3-nzqiBrdOK0K+mO0qqwyGCrjSQ@mail.gmail.com>
 <CANeU7Q=Y7mx501ZAvXesWCL_C92RsjQvFNJ_4dLvUeOg2chFhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35312 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753601AbdCFQts (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2017 11:49:48 -0500
Received: by mail-wm0-f53.google.com with SMTP id v186so68979702wmd.0
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 08:49:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=Y7mx501ZAvXesWCL_C92RsjQvFNJ_4dLvUeOg2chFhg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 07, 2017 at 12:22:07AM +0800, Christopher Li wrote:
> On Mon, Mar 6, 2017 at 11:32 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
> >
> > Sparse-llvm appears to bypass the normal struct GEP in LLVM. It
> > basically casts everything to char *, uses GEP to obtain a pointer to
> > member, and then casts it back to member type. So this should work for
> > structs and unions.
> 
> That is exactly my question. I haven't understand how this by pass
> can work in all the situation.
> 
> >
> > This case is more about handing pointer arithmetic correctly. Here GEP
> > is being used as array element access and not for struct member
> > access.
> 
> Even using array element access, I still have some question regarding
> the the mapping process of the array index.
> Correct me if I am wrong, the GEP indices are express as array index.
> So after convert to (char*) + offset, the offset will express as
> n*(sizeof(element type)).
> "n" is the array index.
> 
> However, the OP_ADD instruction, the offset is byte offset value. The offset
> part might not be align to n*(sizeof(array_elelment)). Assume we can use
> some pack struct to get some member located not at the natural alignment offset.
> 
> Even if the offset is at the type size alignment, shouldn't the indices express
> as ( offset / sizeof(element type))? What do I miss?

With an example:
== C code ==
	void *foo(int *p) { return p + 5; }

== linearized code ==
	foo:
	.L0:
	        <entry-point>
	        add.64      %r2 <- %arg1, $20
	        cast.64     %r3 <- (64) %r2
	        ret.64      %r3

== LLVM code from sparse-llvm ==
	; ModuleID = '<stdin>'
	source_filename = "sparse"
	
	define i8* @foo(i32* %ARG1) {
	L0:
	  %0 = getelementptr i32, i32* %ARG1, inttoptr (i64 20 to i32*)
	  %R3 = bitcast i32* %0 to i8*
	  ret i8* %R3
	}


-- Luc
