From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf] bpf: Improve bucket_log calculation logic
Date: Fri, 7 Feb 2020 12:13:03 -0800
Message-ID: <20200207201301.wpq4abick4j3rucl@ast-mbp.dhcp.thefacebook.com>
References: <20200207081810.3918919-1-kafai@fb.com>
 <CAHk-=wieADOQcYkehVN7meevnd3jZrq06NkmyH9GGR==2rEpuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=wieADOQcYkehVN7meevnd3jZrq06NkmyH9GGR==2rEpuQ@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, David Miller <davem@davemloft.net>, kernel-team@fb.com, Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Netdev <netdev@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>
List-Id: linux-sparse@vger.kernel.org

On Fri, Feb 07, 2020 at 10:07:32AM -0800, Linus Torvalds wrote:
> On Fri, Feb 7, 2020 at 12:18 AM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > It was reported that the max_t, ilog2, and roundup_pow_of_two macros have
> > exponential effects on the number of states in the sparse checker.
> 
> Patch looks good, but I'd like to point out that it's not just sparse.
> 
> You can see it with a simple
> 
>     make net/core/bpf_sk_storage.i
>     grep 'smap->bucket_log = ' net/core/bpf_sk_storage.i | wc
> 
> and see the end result:
> 
>       1  365071 2686974
> 
> That's one line (the assignment line) that is 2,686,974 characters in length.

In addition to this patch I've tried:
diff --git a/include/linux/log2.h b/include/linux/log2.h
index 83a4a3ca3e8a..7363abf60854 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -74,74 +74,76 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
  * Use this where sparse expects a true constant expression, e.g. for array
  * indices.
  */
-#define const_ilog2(n)                         \
-(                                              \
-       __builtin_constant_p(n) ? (             \
-               (n) < 2 ? 0 :                   \
-               (n) & (1ULL << 63) ? 63 :       \
-               (n) & (1ULL << 62) ? 62 :       \
...
+#define __const_ilog2(n, unique_n) ({                  \
+       typeof(n) unique_n = (n);                       \
+       __builtin_constant_p(unique_n) ? (              \
+               (unique_n) < 2 ? 0 :                    \
+               (unique_n) & (1ULL << 63) ? 63 :        \
+               (unique_n) & (1ULL << 62) ? 62 :        \
+               (unique_n) & (1ULL << 61) ? 61 :        \
+               (unique_n) & (1ULL << 60) ? 60 :        \
+               (unique_n) & (1ULL << 59) ? 59 :        \
...
+               (unique_n) & (1ULL <<  3) ?  3 :        \
+               (unique_n) & (1ULL <<  2) ?  2 :        \
                1) :                            \
-       -1)
+       -1; })
+
+#define const_ilog2(n) __const_ilog2(n, __UNIQUE_ID(__n))

and for this nested ilog2() case that caused this explosion
the line got shorter: from 2.6M characters to 144k.
Still a lot.
Unfortunately this approach doesn't work in all cases:
../include/linux/log2.h:77:36: error: braced-group within expression allowed only inside a function
   77 | #define __const_ilog2(n, unique_n) ({   \
      |                                    ^
../include/linux/log2.h:146:24: note: in expansion of macro ‘__const_ilog2’
  146 | #define const_ilog2(n) __const_ilog2(n, __UNIQUE_ID(__n))
      |                        ^~~~~~~~~~~~~
../include/linux/log2.h:161:2: note: in expansion of macro ‘const_ilog2’
  161 |  const_ilog2(n) :  \
      |  ^~~~~~~~~~~
../include/linux/blockgroup_lock.h:14:27: note: in expansion of macro ‘ilog2’
   14 | #define NR_BG_LOCKS (4 << ilog2(NR_CPUS < 32 ? NR_CPUS : 32))
      |                           ^~~~~
../include/linux/blockgroup_lock.h:24:24: note: in expansion of macro ‘NR_BG_LOCKS’
   24 |  struct bgl_lock locks[NR_BG_LOCKS];

Just fyi for folks who're looking at ilog2 and wondering
why it was done this way without ({ })
