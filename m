From: Dave Jones <davej@redhat.com>
Subject: Re: bad asm goto ?
Date: Mon, 25 Oct 2010 18:39:57 -0400
Message-ID: <20101025223957.GA5561@redhat.com>
References: <20101025213145.GA1822@redhat.com>
 <AANLkTikVt5BJ+2W3P+wYUR3DLzhTatXhAW45wdc0eoOe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12413 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065Ab0JYWlB (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Oct 2010 18:41:01 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikVt5BJ+2W3P+wYUR3DLzhTatXhAW45wdc0eoOe@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Mon, Oct 25, 2010 at 03:10:29PM -0700, Christopher Li wrote:
 > On Mon, Oct 25, 2010 at 2:31 PM, Dave Jones <davej@redhat.com> wrote:
 > > I just ran sparse on a kernel tree for the first time in ages, and got
 > > hundreds of warnings, many of which related to the tracepoint macros
 > > in the kernel, which use the new asm goto feature.
 > >
 > > Looking at the git log of sparse, I see there was some support added
 > > for asm goto, but it seems to choke every time, printing ..
 > >
 > > include/trace/events/kmem.h:45:1: error: bad asm output
 > > include/trace/events/kmem.h:45:1: error: incompatible types in comparison expression (different address spaces)
 > >
 > >
 > > (this is with a sparse built from git head from a few minutes ago)
 > 
 > Do you have a smaller test case to reproduce the error?

I tried unwinding some of the nested macros, and came up with ..

# define __ASM_FORM(x)  " " #x " "
# define JUMP_LABEL_INITIAL_NOP ".byte 0xe9 \n\t .long 0\n\t"
# define __ASM_SEL(a,b) __ASM_FORM(b)
#define _ASM_PTR        __ASM_SEL(.long, .quad)

# define JUMP_LABEL(key, label)                                 \
        do {                                                    \
                asm goto("1:"                                   \
                        JUMP_LABEL_INITIAL_NOP                  \
                        ".pushsection __jump_table,  \"a\" \n\t"\
                        _ASM_PTR "1b, %l[" #label "], %c0 \n\t" \
                        ".popsection \n\t"                      \
                        : :  "i" (key) :  : label);             \
        } while (0)

int main(int argc, char *argv[])
{
        JUMP_LABEL("1", do_trace );
        return 1;
do_trace:
        return 0;
}

gcc seems to not choke on it, but sparse still does, so I think I managed
to untangle things correctly..

	Dave
