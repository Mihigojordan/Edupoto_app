 import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';

Widget schoolBurser(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: requirements.length,
      itemBuilder: (context, index) {
        final requirement = requirements[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  requirement['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  requirement['description'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${requirement['amount'].toStringAsFixed(2)}RWF',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle payment for this requirement
                        _handlePayment(requirement);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1b4922),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Pay Now',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handlePayment(Map<String, dynamic> requirement) {
    // Simulate payment process
    print('Payment initiated for: ${requirement['title']}');
    // You can integrate a payment gateway here (e.g., Stripe, PayPal, etc.)
  }

   Widget headteacherMessage(BuildContext context) {
    // final TextEditingController searchController = TextEditingController();
    // widget.fromEdit! ? searchController.text = phoneNumber! : const SizedBox();
    return  ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text(
              message['sender']!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              message['message']!,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            leading: const CircleAvatar(
              backgroundColor: const Color(0xFF1b4922),
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
        );
      },
 
    );
  }

   Widget schoolProspectus(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection(
          title: '1. Introduction',
          children: [
            _buildSubSection(
              title: 'Welcome Message',
              content:
                  'Welcome to Green Hills Academy, a leading international school in Kigali, Rwanda. Our mission is to provide a world-class education that nurtures intellectual, emotional, and social growth. We are committed to fostering a culture of excellence, integrity, and global citizenship.',
            ),
            _buildSubSection(
              title: 'School Overview',
              content:
                  'Green Hills Academy was founded in 1997 and has since grown into one of Rwanda’s most prestigious schools. We follow the International Baccalaureate (IB) curriculum, offering the Primary Years Programme (PYP), Middle Years Programme (MYP), and Diploma Programme (DP). Our ethos is rooted in respect, responsibility, and lifelong learning.',
            ),
          ],
        ),
        _buildSection(
          title: '2. School Information',
          children: [
            _buildSubSection(
              title: 'Contact Details',
              content: 'Address: KG 541 St, Kigali, Rwanda\nPhone: +250 788 310 000\nEmail: info@greenhills.ac.rw\nWebsite: www.greenhills.ac.rw',
            ),
            _buildSubSection(
              title: 'Location Map',
              content: 'Located in the serene neighborhood of Nyarutarama, Green Hills Academy is easily accessible from all parts of Kigali. Nearby transport links include major bus routes and ample parking for parents.',
            ),
          ],
        ),
        _buildSection(
          title: '3. Academic Program',
          children: [
            _buildSubSection(
              title: 'Curriculum Overview',
              content: 'Green Hills Academy offers the International Baccalaureate (IB) curriculum, which is recognized worldwide for its rigorous academic standards and emphasis on critical thinking, creativity, and global awareness.',
            ),
            _buildSubSection(
              title: 'Special Programs',
              content: 'We provide specialized programs for gifted and talented students, as well as support for students with special educational needs (SEN). Our language programs include English, French, and Kinyarwanda.',
            ),
            _buildSubSection(
              title: 'Examination Results',
              content: 'Our students consistently achieve outstanding results in IB examinations, with many gaining admission to top universities worldwide.',
            ),
          ],
        ),
        _buildSection(
          title: '4. Extracurricular Activities',
          children: [
            _buildSubSection(
              title: 'Clubs and Societies',
              content: 'We offer a wide range of clubs, including debate, robotics, music, drama, and environmental clubs. Students can also join sports teams such as basketball, football, and swimming.',
            ),
            _buildSubSection(
              title: 'Trips and Excursions',
              content: 'Our students participate in cultural exchanges, outdoor education programs, and field trips to historical and natural sites in Rwanda and beyond.',
            ),
            _buildSubSection(
              title: 'Sports and Arts',
              content: 'Green Hills Academy has a strong tradition of excellence in sports and the arts. Our students have won numerous awards in music, drama, and athletics at national and international levels.',
            ),
          ],
        ),
        _buildSection(
          title: '5. Facilities',
          children: [
            _buildSubSection(
              title: 'Campus and Buildings',
              content: 'Our campus features state-of-the-art facilities, including modern classrooms, science and computer labs, a well-stocked library, sports fields, and a performing arts center.',
            ),
          ],
        ),
        _buildSection(
          title: '7. Staff and Leadership',
          children: [
            _buildSubSection(
              title: 'Leadership Team',
              content: 'Our leadership team is led by the Head of School, supported by experienced administrators and department heads who are dedicated to providing a nurturing and challenging learning environment.',
            ),
            _buildSubSection(
              title: 'Teaching Staff',
              content: 'Our teachers are highly qualified and experienced professionals, many of whom hold advanced degrees and certifications in their respective fields.',
            ),
            _buildSubSection(
              title: 'Parent-Teacher Associations (PTA)',
              content: 'The PTA at Green Hills Academy plays an active role in supporting the school community. Contact the PTA at pta@greenhills.ac.rw.',
            ),
          ],
        ),
        _buildSection(
          title: '8. Student Life',
          children: [
            _buildSubSection(
              title: 'Uniform and Dress Code',
              content: 'Students are required to wear the official school uniform, which includes a white shirt, navy blue trousers/skirt, and a school blazer. Sports uniforms are required for physical education classes.',
            ),
          ],
        ),
        _buildSection(
          title: '10. Achievements and Accreditations',
          children: [
            _buildSubSection(
              title: 'Awards and Recognition',
              content: 'Green Hills Academy has received numerous accolades, including the Best International School in Rwanda award for five consecutive years.',
            ),
            _buildSubSection(
              title: 'Alumni Success Stories',
              content: 'Our alumni have gone on to study at prestigious universities such as Harvard, MIT, and the University of Oxford. Many are now leaders in their respective fields.',
            ),
          ],
        ),
        _buildSection(
          title: '11. Fees and Financial Information',
          children: [
            _buildSubSection(
              title: 'Fee Structure',
              content: 'Tuition fees for the academic year 2023-2024 are as follows:\n- Primary School: RWF 5,000,000 per term\n- Secondary School: RWF 6,500,000 per term\nAdditional costs include uniforms, textbooks, and extracurricular activities.',
            ),
          ],
        ),
        _buildSection(
          title: '12. Future Plans',
          children: [
            _buildSubSection(
              title: 'Development Projects',
              content: 'We are currently expanding our campus to include a new STEM center and a multipurpose sports complex, scheduled for completion in 2024.',
            ),
            _buildSubSection(
              title: 'Strategic Vision',
              content: 'Our long-term vision is to become a leading center of excellence in education in Africa, fostering innovation, leadership, and global citizenship.',
            ),
          ],
        ),
        _buildSection(
          title: '13. Testimonials',
          children: [
            _buildSubSection(
              title: 'Student Voices',
              content: '"Green Hills Academy has given me the tools to succeed academically and personally. The teachers are supportive, and the environment is inspiring." - John, Grade 12 Student',
            ),
            _buildSubSection(
              title: 'Parent Feedback',
              content: '"We are thrilled with the quality of education and the values instilled in our children. Green Hills Academy is truly a second home for them." - Mrs. Uwera, Parent',
            ),
          ],
        ),
        _buildSection(
          title: '14. School Album',
          children: [
            _buildSubSection(
              title: 'Photos and Graphics',
              content: 'Explore our photo gallery to see our students in action, from classroom learning to sports and cultural events.',
            ),
            _buildSubSection(
              title: 'Infographics',
              content: 'Visual representations of our academic achievements, student demographics, and community impact.',
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildSection({required String title, required List<Widget> children}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color:  Color(0xFF1b4922),
        ),
      ),
      const SizedBox(height: 8),
      ...children,
      const SizedBox(height: 20),
    ],
  );
}

Widget _buildSubSection({required String title, required String content}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        content,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      const SizedBox(height: 12),
    ],
  );
}


   Widget schoolNews(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: newsArticles.length,
      itemBuilder: (context, index) {
        final article = newsArticles[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article['image'] != null)
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.asset(
                    article['image'],
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      article['date'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      article['description'],
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

   Widget schoolAdmissions(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAdmissionSection(
            title: 'Admission Process',
            children: [
              _buildStep(
                step: 1,
                title: 'Fill Admission Form',
                description: 'Complete the online admission form with accurate details.',
                actionText: 'Start Form',
                onAction: () {
                  print('Admission form started');
                },
              ),
              _buildStep(
                step: 2,
                title: 'Upload Required Documents',
                description: 'Upload the following documents: Birth Certificate, Previous School Report, and Passport Photo.',
                actionText: 'Upload Documents',
                onAction: () {
                  print('Upload documents clicked');
                },
              ),
              _buildStep(
                step: 3,
                title: 'Pay Admission Fees',
                description: 'Pay the admission fee of RWF 50,000 to complete the process.',
                actionText: 'Pay Now',
                onAction: () {
                  print('Payment initiated');
                },
              ),
              _buildStep(
                step: 4,
                title: 'Schedule an Interview',
                description: 'Book an interview slot for your child with the school administration.',
                actionText: 'Book Interview',
                onAction: () {
                  print('Interview booking started');
                },
              ),
              _buildStep(
                step: 5,
                title: 'Receive Admission Letter',
                description: 'Once approved, you will receive an admission letter via email.',
                actionText: 'Check Email',
                onAction: () {
                  print('Check email clicked');
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSection(
            title: 'Admission Requirements',
            children: [
              _buildRequirement(
                title: 'Age Requirement',
                description: 'Students must be between 5 and 18 years old.',
              ),
              _buildRequirement(
                title: 'Academic Records',
                description: 'Submit previous school reports or transcripts.',
              ),
              _buildRequirement(
                title: 'Health Records',
                description: 'Provide a medical certificate and vaccination records.',
              ),
              _buildRequirement(
                title: 'Parent/Guardian ID',
                description: 'Upload a copy of the parent/guardian\'s national ID.',
              ),
              _buildRequirement(
                title: 'Passport Photo',
                description: 'Submit a recent passport-sized photo of the student.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdmissionSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1b4922),
          ),
        ),
        const SizedBox(height: 8),
        ...children,
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildStep({
    required int step,
    required String title,
    required String description,
    required String actionText,
    required VoidCallback onAction,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Step $step: $title',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onAction,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1b4922),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                actionText,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirement({required String title, required String description}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

    Widget schoolDownloads(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: reports.length,
      itemBuilder: (context, index) {
        final report = reports[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  report['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  report['description'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  report['date'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle download for this report/receipt
                    _handleDownload(report['fileUrl']);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1b4922),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Download',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleDownload(String fileUrl) {
    // Simulate download process
    print('Downloading file from: $fileUrl');
    // You can integrate a file downloader here (e.g., flutter_downloader, dio, etc.)
  }