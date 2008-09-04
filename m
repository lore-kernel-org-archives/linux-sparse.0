From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: [PATCH 0/10] Sparse linker
Date: Thu, 4 Sep 2008 17:29:22 +0400
Message-ID: <f19298770809040629t1eb86f2co66a87e564bcd8684@mail.gmail.com>
References: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
	 <70318cbf0809031808u8610f3h4b3d53a7b76a7799@mail.gmail.com>
	 <70318cbf0809031816m69565c5aj9417d9a2e136770d@mail.gmail.com>
	 <f19298770809032103h5ea34122g44fda595d775cecf@mail.gmail.com>
	 <70318cbf0809040027i79476a4ds3d1086f5ca434d9d@mail.gmail.com>
	 <f19298770809040241h39703754i5bcac349e1d151c6@mail.gmail.com>
	 <70318cbf0809040335k5ea24032sffc11a8793b43b40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:39458 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbYIDN3X (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 4 Sep 2008 09:29:23 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2294856waf.23
        for <linux-sparse@vger.kernel.org>; Thu, 04 Sep 2008 06:29:22 -0700 (PDT)
In-Reply-To: <70318cbf0809040335k5ea24032sffc11a8793b43b40@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>

On Thu, Sep 4, 2008 at 2:35 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Thu, Sep 4, 2008 at 2:41 AM, Alexey Zaytsev <alexey.zaytsev@gmail.com> wrote:
>> No, that's not how it works. ;)
>> Please compile and run the code. And look at what is actually generated.
>> Or wait a bit, I'll try to describe the serialization process in more detail.
>>
>
> I did. It generate C *source* code like this:
>
> =============cut =============
> #include "test.sparse_declarations.c"
>
> #define NULL ((void *)0)
> static struct a_wrapper __a_0 = {
>        .payload = {
>                .d = 1,
>                .b_ptr = &__b_0.payload,
>        },
> };
> static struct b_wrapper __b_0 = {
>        .payload = {
>                .k = 11,
>                .a_ptr = &__a_1.payload,
>        },
> };
> ============ paste ===========
>
> I assume you intend to use a real compiler(gcc) to compile
> and link that code, no?
>
> I haven't fully understand how you use that piece of C code. But my
> gut feeling is that we shouldn't need to do that C source code
> generation at all.
Ok, let me try to explain how the stuff works. Please note that in
fact two files are generated, output.sparse.c and
output.sparse_declarations.c. This is required to have only one pass
over the serialized data. When we are in the process of serializing
"struct a1", and it points to a "struct b2", we can add  b2 to the
"serialization queue" and dump it after we finish with a1, but we
need to have the declaration somewhere before a1, so we add it to
the _declarations.c file, and #include it from near the output.sparse.c's
start.

Now let's look at an example (a simplified version of serialization-test):

===== test.h =====

struct a {
        int d;
        struct a *a_ptr;
};

DECLARE_WRAPPER(a);
 ^-- Declares struct a_wrapper {struct serialization_mdata meta;
struct a payload;};
and allocation wrapper prototypes.

====== test.c =====

[... helper functions ...]

.- That's the actual user-defined serialization function.
v       All that is needed to serialize any "struct a";
int dump_a(struct serialization_stream *s, struct a *w)
{
        emit_int(s, w, d); <-- dump the int a.d field.
        emit_ptr(s, w, a, a_ptr); <-- dump the struct a * a.a_ptr field.
        /* We could choose to not dump some fields, or choose to dump
         * them conditionally, etc */
        return 0;
}

WRAP(a, "test.h", dump_a);
^-- Defines the allocation wrappers, so that when you call __alloc_a(0),
a "struct a_wrapper" is allocated, and a pointer to its payload field (of
type "struct a") is returned. Also defines the serialization functions for
this type. The second argument is the header that contains the
"struct a" and "struct a_swapper" definitions. It's #included into the
generated file.

Now we allocate a few "struct a" instances, cross-reference them, and
call the serialization function on one of them:

int main(int argc, char **argv)
{
        struct serialization_stream *s;

        struct a *aa = __alloc_a(0);
        struct a *ab = __alloc_a(0);
        struct a *ac = __alloc_a(0);

        aa->d = 1;
        ab->d = 2;
        ac->d = 3;

        aa->a_ptr = ab;
        ab->a_ptr = ac;
        ac->a_ptr = aa

        s = new_serialization_stream("test");

        serialize_a(s, aa, "aa");
        ^- This function was defined through WRAP(a, ...);
        Look at the DO_WRAP monster from serialization.h:

        serialize_a() does the following:

        1 It calls schedule_a_serialization, that:

 88         int schedule_##type_name##_serialization(struct
serialization_stream *s,\
 89                 type *t)
             \
 90         {
             \
 91                 struct type_name##_wrapper *w;
             \
 92                 if (!t)
             \
 93                         return 0; /* Tried to serialize a NULL
pointer */       \
 94                 w = container(t, struct type_name##_wrapper,
payload);          \
 95 (1.1)           if (w->meta.declared)
             \
 96                         return 0;       /* Either already
serialized or waiting \
 97                                          * in the queue */
             \
 98 (1.2)           if (!type_name##_index)
             \
 99                         fprintf(s->declaration_f,
             \
100                                 "\n#include %s\n", #type_header);
             \
101
             \
102                 w->meta.index = type_name##_index++;
             \
103 (1.3)           fprintf(s->declaration_f,
             \
104                         "static struct " #type_name "_wrapper "
             \
105                         "__" #type_name "_%d;\n",
             \
106                         w->meta.index);
             \
107                 w->meta.declared = 1;
             \
108 (1.4)           return serialization_stream_enqueue(s, w,
             \
109                         do_serialize_##type_name);
             \
110         }
                1.1 checks the metadata associated with this instance to
                    see if it was already serialized

                1.2 If not, checks if any structure of type "struct a"
was serialized,
                    and adds #include "test.h" into the
output.sparse_declarations.c.
                    a_index beind a global counter associated with
"struct a", that
                    is incrementd every time a "struct a" is being serialized
                    Its values are assigned to the serialized instances.

                    This resulting in:
test.sparse_declarations.c:2    #include "serialization-test.h"

                1.3 Defines an struct a_wrapper instance in the
declarations file and
                    marks the aa instance as being serialized:
                    This resulting in:
test.sparse_declarations.c:3    static struct a_wrapper __a_0;

                1.4 Calls the serialization_stream_enqueue() function,
which allocates
                    a struct serialization_sched_work that binds the
aa instance and
                    the dump_a() user-supplied dunmper function
(through do_serialize_a())
                    to the "serialization stream" s. Returns to serialize_a().

        2 Calls process_serialization_queue(), that for every enqueued
data instance,
          calls the do_serialize_##type_name, that was bound to it at
step 1.3. The idea
          is, that if your structure references numerous other
structures, they all will
          be added to the queue by your user-supplied serializer
(transparently, through
          the emit_ptr function) and serialized before the loop exits:
40 int process_serialization_queue(struct serialization_stream *s)
 41 {
 42       int ret = 0;
 43       struct serialization_sched_work *w;
 45       while (s->queue) {
 46               w = s->queue;
 47               s->queue = s->queue->next;
 48               ret = w->serializer(s, w->unit); <- Here new
structures might get added
 49               free(w);      ^                       to the queue
as dependencies.
 50       }                     \ calls do_serialize_a(...)

          ret =  w->serializer(s, w->unit) points at do_serialize_a() that does:

 73       static int do_serialize_##type_name(struct
serialization_stream *s,     \
 74               void *unit)
           \
 75       {
           \
 76               struct type_name##_wrapper *w = unit;
           \
 77               int ret;
           \
 78 (2.1)         fprintf(s->definition_f, "static struct " #type_name
"_wrapper "\
 79                       "__" #type_name "_%d = {\n\t.payload = {\n",
           \
 80                       w->meta.index);
           \
 81 (2.2)         ret = serializer(s, &w->payload); <-- dump_a()
           \
 82 (2.3)         fprintf(s->definition_f, "\t},\n};\n");
           \
 83               if (ret)
           \
 84                       fprintf(stderr, "Warning: Failed to
serialize a " #type \
 85                       ": %d\n", ret);
           \
 86               return ret;
           \
 87       }
           \

                2.1 In the output.sparse.c file it adds an a_wrapper
instance, numbered
                    acording to the index assocoated to the structure
(step 1.2):
                    This resulting in:

test.sparse.c:4     static struct a_wrapper __a_0 = {
test.sparse.c:5            .payload = {

                    Note that __a_0 is derived not from the serialized
instance's
                    name (aa), but from the type name and the instance's index.

                2.2 Finally runs the user-supplied function (dump_a):

                    That does the following:
                        2.3.1 calls emit_int to dump the a.d field:
                              emit_int(s, w, d);
                              emit_int being: *
146 #define emit_int(s, parent, field)
             \
147         do {
             \
148                 int __i = parent->field;
             \
149                 fprintf(s->definition_f, "\t\t." #field " =
%d,\n", __i);       \
150         } while (0)
                              and resulting into:
test.sparse.c:6 .d = 1,
                        2.3.2 calls emit_ptr(s, w, a, a_ptr) that does:

                                         .------.- Here type being the name of
                                         v      v        the pointed-to type.
172 #define do_emit_ptr(stream, parent, type, type_name, field) **
             \
173         do {
             \
174                 struct type_name##_wrapper *__w;
             \
175                 void *__ptr = parent->field;
             \
176 (2.3.2.1)       if (!__ptr) {
             \
177                         fprintf(stream->definition_f,
             \
178                                 "\t\t." #field " = NULL,\n");
             \
179                         break;
             \
180                 }
             \
181 (2.3.2.2)       schedule_##type_name##_serialization(stream,
__ptr);            \
182                 __w = container(__ptr, struct type_name##_wrapper,
payload);    \
183 (2.3.2.3)       fprintf(stream->definition_f, "\t\t." #field " =
&"             \
184                         "__" #type_name "_%d.payload,\n",
__w->meta.index);     \
185         } while (0)
                                2.3.2.1 check the pointer for NULL.
                                2.3.2.2 Schedules the pointed-to structure for
                                        serializetion. The pointed-to
structure's
                                        is passed as the third
argument to emit_ptr().
                                        See point 1 on how
schedule_##type_name##_serialization
                                        works, resulting into the
pointed-to being added to
                                        the declatarion file and to
the serialization qeueue:

test.sparse_declarations.c:4  static struct a_wrapper __a_1;

                                2.3.2.3 Dumps the requisted field
(a_ptr), resulting in:
test.sparse.c:7 .a_ptr = &__a_1.payload,
                                __a_1 being the pointed-to structure's wrapper,
                                 declared, but not dumped yet.

                2.3 After the user-supplied function returns, closes the now
                    serialized structure:
test.sparse.c:8          },
test.sparse.c:9 };

                2.4 Now the process_serialization_queue's loop
iterates again, as a new
                    instance (ab) was added at the step 2.3.2.2, and
again, as this instance
                    references a third struct (ac). ac references the
first struct, aa, but
                    schedule_a_serialization() would see at step 1.1
that it was already
                    serialized, and would return right away, leadin to
the loop termination.

                    After this, we should have the following data:

test.sparse_declarations.c:2 #include "serialization-test.h"
test.sparse_declarations.c:3 static struct a_wrapper __a_0;
test.sparse_declarations.c:4 static struct a_wrapper __a_1;
test.sparse_declarations.c:5 static struct a_wrapper __a_2;

test.sparse.c:1 #include "test.sparse_declarations.c"
test.sparse.c:2
test.sparse.c:3 #define NULL ((void *)0)
test.sparse.c:4 static struct a_wrapper __a_0 = {
test.sparse.c:5         .payload = {
test.sparse.c:6                 .d = 1,
test.sparse.c:7                 .a_ptr = &__a_1.payload,
test.sparse.c:8         },
test.sparse.c:9 };
test.sparse.c:0 static struct a_wrapper __a_1 = {
test.sparse.c:1         .payload = {
test.sparse.c:2                 .d = 2,
test.sparse.c:3                 .a_ptr = &__a_2.payload,
test.sparse.c:4         },
test.sparse.c:5 };
test.sparse.c:6 static struct a_wrapper __a_2 = {
test.sparse.c:7         .payload = {
test.sparse.c:8                 .d = 3,
test.sparse.c:9                 .a_ptr = &__a_0.payload,
test.sparse.c:0         },
test.sparse.c:1 };

        3 At this point, we've got all the data, except it's
          all static. One final touch is to add a global reference
          to the structure that we serialized (aa):

117                 if (!ret && name)
             \
118                         ret = label_##type_name##_entry(s, t,
name);            \
119                 return ret;
             \
120         }
             \

121         int label_##type_name##_entry(struct serialization_stream
*s, type *t,  \
122                 const char *name)
             \
123         {
             \
124                 struct type_name##_wrapper *w;
             \
125                 if (!t) {
             \
126                         fprintf(s->definition_f, #type " *%s =
NULL;", name);   \
127                         return 0;
             \
128                 }
             \
129                 w = container(t, struct type_name##_wrapper,
payload);          \
130                 if (!w->meta.declared) {
             \
131                         fprintf(stderr, "Warning: Trying to label
an undefined" \
132                                 " '" #type "'\n");
             \
133                         return -1;
             \
134                 }
             \
135                 fprintf(s->definition_f, #type " *%s = &"
             \
136                         "__" #type_name "_%d.payload;\n", name,
w->meta.index); \
137                 return 0;
             \
138         }
          label_a_entry() doing the job:

test.sparse.c:22 struct a *aa = &__a_0.payload;

          If we decide to call serialize_a() on the other two structures,
          only the global pointers would be added, as the structure's
          metadata contains both the definition flag and the instance's index.


* emit_int was fixed, it worked only occasionally. ;)
** seems like we don't need to pass the "type" any more.

Uff. Seems like that's how it works. Now (or after a bit more looking
at the code),
it should be clear, that if in the program we have a "struct a", wrapped into a
"struct a_wrapper" and being serialized, you would see exactly the same struct
appearing in the output file, with the fields you have chosen to serialize.

Q: You tried to look smart or what?
A: Yes, the work was inspired by the ptr lists,
        and I hope I managed to beat Linus here,
        as ptr lists are perfectly serializable. ;)
>
> Chris
>
