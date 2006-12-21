From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Subject: Linux Kernel Markers format string idea
Date: Thu, 21 Dec 2006 11:20:35 -0500
Message-ID: <20061221162035.GA9609@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ltt-dev-bounces@listserv.shafik.org>
Content-Disposition: inline
List-Unsubscribe: <http://listserv.shafik.org/mailman/listinfo/ltt-dev>,
	<mailto:ltt-dev-request@listserv.shafik.org?subject=unsubscribe>
List-Archive: <http://listserv.shafik.org/pipermail/ltt-dev>
List-Post: <mailto:ltt-dev@listserv.shafik.org>
List-Help: <mailto:ltt-dev-request@listserv.shafik.org?subject=help>
List-Subscribe: <http://listserv.shafik.org/mailman/listinfo/ltt-dev>,
	<mailto:ltt-dev-request@listserv.shafik.org?subject=subscribe>
Sender: ltt-dev-bounces@listserv.shafik.org
Errors-To: ltt-dev-bounces@listserv.shafik.org
To: "Frank Ch. Eigler" <fche@redhat.com>, ltt-dev@shafik.org, systemtap@sources.redhat.com, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

Hi,

First, some context : I created the Linux Kernel Markers as a lightweight
code instrumentation mechanism with which we can connect a probe dynamically.
Type checking is done dynamically by comparing the string in the probe to the
string found at the instrumentation site. If we want to have strong type
checking with this mechanism, all the information used for typing must be in
the format string and validated. Frank showed some concerns about the use of
format strings regarding type checking. Here is a proposal to fix this.

I just had an idea about a format string extension that would help fix the
missing type checking with format strings for Linux Kernel Markers. It would
however imply that we extend the format string standard. One of the goals is
to keep backward compatibility with existing format strings.

The two sample cases I would like to "dynamically type check" are the
following :

- Passing a "struct mystruct *" as an argument.
- Passing a "__be64" as an argument
  (typedef as "__u64 __bitwise", where __bitwise is undefined when compiled by
  gcc but is defined as __attribute__((bitwise)) when compiled with __CHECKER__
  for sparse).
  (http://kernel.org/pub/linux/kernel/people/josh/sparse/)

The idea is to add the type between brackets after the conversion specifier.

For a pointer to a structure :
"%p[struct mystruct *]"

For a __be64 :
"%llu[__be64]"

The current format string validation of gcc will not perform more or less
validation than what is actually done, which is to verify that the type is a
pointer or a 64 bytes integer. Printing it through printk will show, for
instance :

0xfffffff[struct mystruct *]
1152921504606846976[__be64]

However, an enhanced format string verificator could check the type of the
pointer and the complete type of the __be64. It could start by being integrated
to the "checker", and only later make its way into gcc.

Comments on this idea are welcome.

Mathieu


-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
