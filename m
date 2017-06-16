From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [GIT PULL] patches for -rc2
Date: Fri, 16 Jun 2017 01:03:00 +0100
Message-ID: <57e076f3-77c6-34c6-b8b5-8301efcc3f7f@ramsayjones.plus.com>
References: <20170615043455.3ke55dyo6v4vpebo@ltop.local>
 <CANeU7QmtKh5LxJVvaFVGy7KApXTtzW+-G19LogbEZH=kTNLHAQ@mail.gmail.com>
 <20170615082050.4ztydiu3d6m4fx2e@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout07.plus.net ([84.93.230.235]:44904 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbdFPADD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 15 Jun 2017 20:03:03 -0400
In-Reply-To: <20170615082050.4ztydiu3d6m4fx2e@ltop.local>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>



On 15/06/17 09:20, Luc Van Oostenryck wrote:
> On Thu, Jun 15, 2017 at 12:11:55AM -0700, Christopher Li wrote:
>> On Wed, Jun 14, 2017 at 9:34 PM, Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>>> Chris,
>>>
>>> Please pull these patches for v0.5.1-rc2.
>>
>> Thanks, I fetch your change already.
> 
> And of course, I had to mess it up by forgetting to add
> my SoB to the new patches for cgcc. Sorry for that.
> I have added them now, as well as adding missing credits,
> and republished the updated version. The patches themselves
> haven't changed, only the commit messages.
> 
> Please, drop what you have already pulled and take the
> following instead.
> 
> Sorry again,
> -- Luc
> 
> The following changes since commit 88578349140acf4405b768a60be05e10b7b8b158:
> 
>   Merge branches 'dump-macros-v2', 'fix-predefined-size', 'fix-bool-context', 'fix-missing-reload', 'fix-insert-branch', 'fix-NULL-type', 'testsuite-clean', 'fix-bitfield-init-v3' and 'fdump-linearize' into tip (2017-05-19 16:11:51 +0200)
> 
> are available in the git repository at:
> 
>   git://github.com/lucvoo/sparse.git tags/for-chris
> 
> for you to fetch changes up to bcfe020ed939fa1e8474efaf31a86d80d0e5c5fe:
> 
>   add support for -fmemcpy-max-count (2017-06-15 10:03:49 +0200)
> 

Hi Chris, Luc,

I decided to fetch this tonight and do a bit of light testing. At first,
things seemed to be going well. ;-)
Viz:

  $ cd git
  $ sparse --version
  v0.5.1-rc1-22-gbcfe020
  $ 
  $ rm pack-revindex.o
  $ make CC=cgcc CFLAGS='-Wall' pack-revindex.o
      * new build flags
      CC pack-revindex.o
  pack-revindex.c:64:23: warning: memset with byte count of 262144
  $ 
  $ rm pack-revindex.o
  $ make CC=cgcc CFLAGS='-Wall -Wmemcpy-max-count' pack-revindex.o
      * new build flags
      CC pack-revindex.o
  pack-revindex.c:64:23: warning: memset with byte count of 262144
  $ 
  $ rm pack-revindex.o
  $ make CC=cgcc CFLAGS='-Wall -Wno-memcpy-max-count' pack-revindex.o
      * new build flags
      CC pack-revindex.o
  $ 
  $ rm pack-revindex.o
  $ make CC=cgcc CFLAGS='-Wall -fmemcpy-max-count=0' pack-revindex.o
      * new build flags
      CC pack-revindex.o
  $ 
  $ rm pack-revindex.o
  $ make CC=cgcc CFLAGS='-Wall -fmemcpy-max-count=262145' pack-revindex.o
      * new build flags
      CC pack-revindex.o
  $ 
  $ rm pack-revindex.o
  $ make CC=cgcc CFLAGS='-Wall -fmemcpy-max-count=262144' pack-revindex.o
      * new build flags
      CC pack-revindex.o
  $ 
  $ rm pack-revindex.o
  $ make CC=cgcc CFLAGS='-Wall -fmemcpy-max-count=262143' pack-revindex.o
      * new build flags
      CC pack-revindex.o
  pack-revindex.c:64:23: warning: memset with byte count of 262144
  $ 

I then ran sparse over the entire git project, as I usually do, to see if
there were any new errors/warnings. Unfortunately, there were, which can
be seen as follows:
 
  $ make builtin/rev-parse.sp
      SP builtin/rev-parse.c
  ./git-compat-util.h:480:22: warning: crazy programmer
  ./git-compat-util.h:480:22: warning: crazy programmer
  ./git-compat-util.h:480:22: warning: crazy programmer
  $ 

I used git-bisect the find the commit responsible for the new warnings,
the end of that session was as follows:

  $ git bisect good
  5636cd5cbf816f30ee57d580ec4debd8e0bd7581 is the first bad commit
  commit 5636cd5cbf816f30ee57d580ec4debd8e0bd7581
  Author: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
  Date:   Wed Jan 4 04:03:21 2017 +0100
  
      missing load simplification
      
      In memops:find_dominating_parents(), the 'load-load optimization'
      (see commit cf07903a "Don't bother finding dominating loads if ...")
      cause some loads simplification to be missed.
      For example, with the following code:
              int foo(int *i, int *j)
              {
                      *i = 6;
                      *j = 1;
      
                      do {
                              if (*i != 6)
                                      (*i)++;
                              (*i)++;
                      } while (*i != *j);
      
                      return *j;
              }
      
      test-linearize returns something like:
              foo:
              .L0:
                      <entry-point>
                      store.32    $6 -> 0[%arg1]
                      store.32    $1 -> 0[%arg2]
                      br          .L1
      
              .L1:
                      load.32     %r4 <- 0[%arg1]
                      setne.32    %r5 <- %r4, $6
                      br          %r5, .L4, .L5
      
              .L4:
                      add.32      %r8 <- %r4, $1
                      store.32    %r8 -> 0[%arg1]
                      br          .L5
      
              .L5:
                      load.32     %r10 <- 0[%arg1]
                      add.32      %r11 <- %r10, $1
                      store.32    %r11 -> 0[%arg1]
                      load.32     %r15 <- 0[%arg2]
                      setne.32    %r16 <- %r11, %r15
                      br          %r16, .L1, .L6
      
              .L6:
                      ret.32      %r15
      
      where we can notice that the first load in .L5 is not needed,
      the value could be retrieved from %r4 and %r8, like:
              @@ -8,15 +8,17 @@
               .L1:
                      load.32     %r4 <- 0[%arg1]
                      setne.32    %r5 <- %r4, $6
              +       phisrc.32   %phi4 <- %r4
                      br          %r5, .L4, .L5
      
               .L4:
                      add.32      %r8 <- %r4, $1
                      store.32    %r8 -> 0[%arg1]
              +       phisrc.32   %phi5 <- %r8
                      br          .L5
      
               .L5:
              -       load.32     %r10 <- 0[%arg1]
              +       phi.32      %r10 <- %phi4, %phi5
                      add.32      %r11 <- %r10, $1
                      store.32    %r11 -> 0[%arg1]
                      load.32     %r15 <- 0[%arg2]
      
      The fix essentially consists in reverting commit cf07903a but on
      memops.c's version of find_dominating_parents().
      
      Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
      Signed-off-by: Christopher Li <sparse@chrisli.org>
  
  :100644 100644 6dac1f57833f1708cff72478de969e6b84726ef5 5efdd6f2dab4e475f02ffb9c02e88469662118d3 M	memops.c
  $ 
  
I tried to create a minimal reproducer, but I just couldn't reduce it at all!

The warning points to the 'while' line of the skip_prefix() function in the
git-compat-util.h header file. This is used all over the place, but it seems
to be only complaining about its use in builtin/rev-parse.c. In particular,
there are 16 inlined calls in the function cmd_rev_parse() alone. So I don't
know which 3 of those inlined calls it is complaining about (the warning
message is not much help ...).

The skip_prefix() function looks like:

static inline int skip_prefix(const char *str, const char *prefix,
			      const char **out)
{
	do {
		if (!*prefix) {
			*out = str;
			return 1;
		}
	} while (*str++ == *prefix++);  /* <<<< this is line 480 */
	return 0;
}

That is as far as I have gone in trying to chase this down. I have to get
some sleep now, so I thought I should let you know what I found so far. :-D

ATB,
Ramsay Jones


